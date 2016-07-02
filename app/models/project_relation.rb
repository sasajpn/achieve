class ProjectRelation < ActiveRecord::Base
    belongs_to :inviting, class_name: "Project"
    belongs_to :invited, class_name: "User"
    belongs_to :approving, class_name: "User"
    belongs_to :approved, class_name: "Project"
end
