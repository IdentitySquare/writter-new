class PostPolicy < ApplicationPolicy
    attr_reader :user, :post
  
    class Scope < Scope
      def resolve
        scope.where(user: @user)
      end
    end
  
    def index?
      true
    end
  
    def show?
      true
    end
  
    def new?
      @user == @record.user
    end
  
    def update?
      user_is_owner?
    end

    def publish?
      user_is_owner?
    end

    def unpublish?
      user_is_owner?
    end
  
    def destroy?
      false
    end

    def user_is_owner?
      @user == @record.user
    end
  end
  