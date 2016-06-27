class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :omniauthable
  
  mount_uploader :image, ImageUploader       

  has_many :blogs, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :tasks, dependent: :destroy
  has_many :task_comments, dependent: :destroy
  has_many :goodjobs, dependent: :destroy
  has_many :projects, dependent: :destroy
  
  has_many :invited_relations, foreign_key: "invited_id", class_name: "ProjectRelation", dependent: :destroy
  has_many :approving_relations, foreign_key: "approving_id", class_name: "ProjectRelation", dependent: :destroy
  
  has_many :invited_projects, through: :invited_relations, source: :inviting
  has_many :approving_projects, through: :approving_relations, source: :approved
  
  # 第一段階「中間テーブルと関係を定義する」
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_relationships, foreign_key: "followed_id", class_name: "Relationship", dependent: :destroy
  
  # 第三段階「相対的な参照関係を定義する」
  has_many :followed_users, through: :relationships, source: :followed
  has_many :followers, through: :reverse_relationships, source: :follower
  
  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end
  
  def unfollow!(other_user)
    relationships.find_by(followed_id: other_user.id).destroy
  end
  
  def following?(other_user)
    relationships.find_by(followed_id: other_user.id)
  end
  
  def each_other_friends
    User.each_other_follows(self)
  end
  
  def self.each_other_follows(user)
    user.followers && user.followed_users
  end
  
  def taskfeed
    each_other_follows = self.followers && self.followed_users
    Task.where(user: each_other_follows)
  end
  
  # def invited?(project)
  #   invited_relations.find_by(inviting_id: project.id)
  # end
  
  def approve!(project)
    approving_relations.create!(approved_id: project.id)
  end
  
  def unapprove!(project)
    approving_relations.find_by(approved_id: project.id).destroy
  end
  
  def approving?(project)
    approving_relations.find_by(approved_id: project.id)
  end
  
  def join_project
    self.invited_projects && self.approving_projects
  end
    
  
  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(provider: auth.provider, uid: auth.uid).first
    unless user 
    if auth.info.email.blank?
    user = User.new(name:     auth.extra.raw_info.name, 
                    provider: auth.provider, 
                    uid:      auth.uid, 
                    email:    User.create_unique_email,
                    password: Devise.friendly_token[0,20])
    else
    user = User.new(name:     auth.extra.raw_info.name, 
                    provider: auth.provider, 
                    uid:      auth.uid, 
                    email:    auth.info.email,
                    password: Devise.friendly_token[0,20])
    end
    end
    user
  end
  
  def self.find_for_twitter_oauth(auth, signed_in_resource=nil)
    user = User.where(provider: auth.provider, uid: auth.uid).first
    unless user
    user = User.new(name:     auth.info.nickname,
                    provider: auth.provider,
                    uid:      auth.uid,
                    email:    User.create_unique_email,
                    password: Devise.friendly_token[0,20])
    end
    user
  end
  
  def self.create_unique_string
    SecureRandom.uuid
  end
  
  def self.create_unique_email
    User.create_unique_string + "@example.com"
  end
  
  def update_without_current_password(params, *options)
    params.delete(:current_password)
 
    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end
 
    result = update_attributes(params, *options)
    clean_up_passwords
    result
  end
  

end
