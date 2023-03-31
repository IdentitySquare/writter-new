class NotificationPolicy < ApplicationPolicy
  attr_reader :user, :notification

  class Scope < Scope
    def resolve
      scope.where(user: @user)
    end
  end
end
  