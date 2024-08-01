class BulletinPolicy < ApplicationPolicy
  attr_reader :user, :bulletin

  def initialize(user, bulletin)
    @user = user
    @bulletin = bulletin
  end
  
  def index?
    true
  end

  def show?
    true
  end

  def create?
    user
  end

  def new?
    create?
  end

  def update?
    bulletin.creator_id == user&.id
  end

  def edit?
    update?
  end

  def destroy?
    bulletin.creator_id == user&.id
  end
end