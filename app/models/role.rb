class Role < ApplicationRecord
  has_many :users
  has_and_belongs_to_many :permissions

  def set_permissions(permissions)
    permissions.each do |id|
      #find the main permission assigned from the UI
      permission = Permission.find(id)
      self.permissions << permission
      case permission.subject_class
      when "Part"
        case permission.action
        #if create part permission is assigned then assign create Post as well
        when "create"
          self.permissions << Permission.where(subject_class: "Post", action: "create")
        #if update part permission is assigned then assign create and delete Post as well
        when "update"
          self.permissions << Permission.where(subject_class: "Post", action: ["update", "destroy"])
        end
      end
    end
  end

end
