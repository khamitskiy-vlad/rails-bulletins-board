# frozen_string_literal: true

class ProfilePolicy < Struct.new(:user, :profile)
  class Scope
    def resolve
      scope
    end
  end
  
  def index?
    false
  end

  def show?
    true
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    owner
  end

  def edit?
    update?
  end

  def destroy?
    owner
  end

  private

  def owner
    profile.id == user.id
  end
end
