class AddAdminToProjectRelation < ActiveRecord::Migration
  def change
    add_column :project_relations, :administer_id, :integer
    add_index :project_relations, :administer_id
    add_column :project_relations, :administered_id, :integer
    add_index :project_relations, :administered_id
  end
end
