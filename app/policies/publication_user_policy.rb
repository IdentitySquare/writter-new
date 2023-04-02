class PublicationUserPolicy < ApplicationPolicy
   
  def destroy?
    !(@record.admin? && @record.publication.admins.count == 1)
  end

end
  