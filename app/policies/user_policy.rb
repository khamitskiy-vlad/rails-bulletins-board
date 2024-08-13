class UserPolicy < ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end
  
  def index?
    false
  end

  def show?
    true
  end

  def create?
    true
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
    user == record
  end
end
