# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can :destroy, Post, user: user
    can :destroy, Post, user: user
  end
end
