class Ability
  include CanCan::Ability

  def initialize(user)
    can :manage, User, id: user.id
    can :manage, Registration, user_id: user.id
    can :manage, Build, user_id: user.id
    
    if user.admin?
      can :manage, :all
    end
  end
end
