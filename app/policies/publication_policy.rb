class PublicationPolicy < ApplicationPolicy
    attr_reader :user, :publication
  
    class Scope < Scope
      def resolve
        scope.where(user: @user)
      end
    end
  
    def index?
      current_user
    end
  
    def show?
      true
    end
  
    def create?
      true
    end
  
    def update?
      current_user_is_admin?
    end
  
    def destroy?
      false
    end

    def current_user_is_admin?
      PublicationUser.admin.where(publication: @record, user: @user).any?
    end

    def current_user_is_editor?
      PublicationUser.editor.where(publication: @record, user: @user).any?
    end
  end
  