class SamplePolicy < ApplicationPolicy
  attr_reader :user, :sample

  def initialize(user, sample)
    @user = user
    @sample = sample
  end

  def show?
    (public? && published?) || owner? || moderator?
  end

  def create?
    true
  end

  def update?
    owner?
  end

  def moderate?
    moderator?
  end

  def destroy?
    owner?
  end

  private

  def public?
    @sample.status_public?
  end

  def published?
    @sample.published?
  end

  def owner?
    sample.user == user
  end

  def moderator?
    user.moderator?
  end
end
