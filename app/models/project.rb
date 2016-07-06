class Project < ActiveRecord::Base
    has_many :tasks, dependent: :destroy
    
    has_many :inviting_relations, foreign_key: "inviting_id", class_name: "ProjectRelation", dependent: :destroy
    has_many :approved_relations, foreign_key: "approved_id", class_name: "ProjectRelation", dependent: :destroy
    
    has_many :inviting_users, through: :inviting_relations, source: :invited
    has_many :approved_users, through: :approved_relations, source: :approving
    
    belongs_to :admin, class_name: "User"
    
    has_many :customers, dependent: :destroy
    
    has_many :notifications, dependent: :destroy
    
    accepts_nested_attributes_for :notifications
    
    def invite!(user)
        inviting_relations.create!(invited_id: user.id)
    end
    
    def uninvite!(user)
        inviting_relations.find_by(invited_id: user.id).destroy
    end
    
    def inviting?(user)
        inviting_relations.find_by(invited_id: user.id)
    end
    
    def project_member
        self.inviting_users && self.approved_users
    end
    
    def leave_member!(user)
        approved_relations.find_by(approving_id: user.id).destroy
        inviting_relations.find_by(invited_id: user.id).destroy
    end
    
    def add_member!(user)
        inviting_relations.create!(invited_id: user.id)
        approved_relations.create!(approving_id: user.id)
    end
end
