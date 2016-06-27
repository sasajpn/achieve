class AddAdminUserIdToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :admin_user_id, :integer, null: false
  end
end
