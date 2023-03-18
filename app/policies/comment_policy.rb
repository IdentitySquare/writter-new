class CommentPolicy < ApplicationPolicy
    attr_reader :user, :comment
  
    class Scope < Scope
      def resolve
        scope.where(user: @user)
      end
    end
  
    def destroy?
      user_is_owner?
    end

    def user_is_owner?
      @user == @record.user
    end
end
  