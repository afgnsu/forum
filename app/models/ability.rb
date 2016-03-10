class Ability
  include CanCan::Ability

=begin
  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.admin?
      can :manage, :all
    elsif user.employee?
      can :read, [Group,Post,Comment]
      can :create, [Group,Post,Comment]
      can :update, Group do |group|
        group.try(:user) == user
      end
      can :destroy, Group do |group|
        group.try(:user) == user
      end
    elsif user.guest?
      can :read, [Group,Post,Comment]
    end
  end

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.admin?
      can :manage, :all
    elsif user.employee?
      can :read, [Group,Post]
      can :create, [Group,Post]
      can :update, Post do |post|
        post.try(:user) == user
      end
      can :destroy, Post do |post|
        post.try(:user) == user
      end
    elsif user.guest?
      can :read, [Group,Post]
    end
  end
=end

  def initialize(user)
    if user.blank?
      guest_only
    elsif user.has_role?(:admin)
      admin_only
    elsif user.has_role?(:employee)
      employee_only
    else
      guest_only
    end
  end

  def guest_only
    can :read, [Group,Post,Comment]
  end

  def employee_only
    can [:create, :update], [Group,Post,Comment]
  end

  def admin_only
    can :manage, :all
  end

end
