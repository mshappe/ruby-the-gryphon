# frozen_string_literal: true

class Ability
  include CanCan::Ability

  # TODO: Eventually, some permissions will be dynamically defined
  def initialize(user)
    user ||= User.new

    alias_action :create, :read, :update, :destroy, to: :crud
    alias_action :create, :read, :update, to: :cru

    # We have no roles yet!
    can :manage, :all if user.has_role? :admin
    can :manage, Event if user.has_role? :event_officer

    # What can be publicly read?
    can :read, [Award, Branch, LibrarySection, LibraryDocument, Person, Persona, Reign]
    can :read, Event, submission_state: 'approved'
    can :search, LibraryDocument
    can %i[read edit update], User, id: user.id

    # What belongs to a specific user and can be edited by that user
    can :update, Person, user_id: user.id
    can :crud, Persona, user_id: user.id

    can :crud, Warrant do |warrant|
      # Only great officers
      current_go_warrants = (WarrantType.great_offices.pluck(:id) & user.warrants.current.pluck(:warrant_type_id))

      # Only the subordinate warrants that are ours
      current_go_warrants.include?(warrant.warrant_type&.superior_warrant_id)
    end

    can :queued, Warrant
    
    # Anyone can read their own warrants
    can :read, Warrant, person_id: user&.person&.id

    # Any logged in user can create warrants (an officer change request is an unapproved warrant object)
    can :create, Warrant if user.persisted?

    can :create, Event if user.persisted? # No visitors
    can [:create, :edit], Event do |event| # Event is inexplicably tied to personas. We chose not to change this right now.
      user.personas.pluck(:id).include?(event.submitter_persona_id)
    end

    can [:read, :search], WarrantType
    can :cru, Post, persona_id: user.persona_ids
    can :read, Post do |post|
      !post.approved.nil?
    end
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
