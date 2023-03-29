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
      if @record.publication.present?
        author_is_part_of_publication && (user_is_owner? || user_is_editing_member_of_publication?)
      else
        user_is_owner? 
      end
    end

    def publish?
      update?
    end

    def unpublish?
      update?
    end
  
    def destroy?
      false
    end

    def remove_from_publication?
      if @record.publication.present?
        user_is_editing_member_of_publication?
      else
        user_is_owner? 
      end
    end

    def user_is_owner?
      @user == @record.user
    end

    def user_is_editing_member_of_publication?
      if @record.publication.present?
        @record.publication.editors&.pluck(:user_id)&.include?(@user.id) ||@record.publication.admins&.pluck(:user_id)&.include?(@user.id)        
      end
    end

    def author_is_part_of_publication
      @record.publication.members&.pluck(:user_id)&.include?(@user.id) 
    end
  end
  