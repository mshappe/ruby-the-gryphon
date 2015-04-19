class Ability
  include CanCan::Ability

  # TODO Eventually, some permissions will be dynamically defined
  def initialize(user)
    user ||= User.new

    alias_action :create, :read, :update, :destroy, :to => :crud

    # We have no roles yet!
    can :manage, :all if user.has_role? :admin

    # What can be publicly read?
    can :read, [Person, Persona]

    # What belongs to a specific user and can be edited by that user
    can :update, Person,  user_id: user.id
    can :crud, Persona, user_id: user.id

    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
