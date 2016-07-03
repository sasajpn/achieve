class Task < ActiveRecord::Base
  has_many :task_comments, dependent: :destroy
  has_many :goodjobs, dependent: :destroy
  has_many :submit_requests, dependent: :destroy
  belongs_to :user
  belongs_to :charge, class_name: 'User', foreign_key: 'charge_id'
  belongs_to :project
  validates :title, presence: true
  validates :content, presence: true
  
  def self.each_other_follows(user)
    user.followers && user.followed_users
  end
end
