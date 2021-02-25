# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    
    user ||= User.new # guest user (not logged in)
    
    can :manage, :all
    can :write, Person
    cannot :edit, Person
    cannot :destroy, Person

    
    if user.has_role? :admin
      can :manage, :all
    end

  end
end
