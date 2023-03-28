class PublicationUserPolicy < ApplicationPolicy
   
  def destroy?
    debugger
    !(@record.admin? && @record.publication.admins.count == 1)
  end

end
  