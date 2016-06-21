class Blog < ActiveRecord::Base
    belongs_to :user
    has_,any :comments
end
