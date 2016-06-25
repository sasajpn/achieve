class Relationship < ActiveRecord::Base
    # 第二段階「フォロー・フォロワーの識別」
    belongs_to :follower, class_name: "User"
    belongs_to :followed, class_name: "User"
end
