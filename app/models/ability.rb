class Ability
  include CanCan::Ability
  def initialize(user)
    if user == nil
      user = User.new
      user.role = 'guest'
    end

    if user.role?("admin")
      can :manage, :all
    elsif user.role?("user")
      can :read, Feed
      can :create, Feed
      can :destroy, Feed
      can :update, Feed
      can :retrieve, Feed
    elsif user.role?("guest")

    end
    end
end
