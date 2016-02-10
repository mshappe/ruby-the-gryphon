class Ability
  include CanCan::Ability

  # TODO Eventually, some permissions will be dynamically defined
  def initialize(user)
    user ||= User.new

    alias_action :create, :read, :update, :destroy, to: :crud
    alias_action :create, :read, :update, to: :cru

    # We have no roles yet!
    can :manage, :all if user.has_role? :admin
    can :manage, Event if user.has_role? :event_officer

    # What can be publicly read?
    can :read, [Award, Branch, Person, Persona]
    can :read, Event, submission_state: 'approved'
    can :read, User, id: user.id

    # What belongs to a specific user and can be edited by that user
    can :update, Person,  user_id: user.id
    can :crud, Persona, user_id: user.id

    can :create, Event if user.persisted? # No visitors
    can [:create, :edit], Event do |event| # Event is inexplicably tied to personas. We chose not to change this right now.
      user.personas.pluck(:id).include?(event.submitter_persona_id)
    end

    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
