class CreateProjectRelations < ActiveRecord::Migration
  def change
    create_table :project_relations do |t|
      t.integer :inviting_id
      t.integer :invited_id
      t.integer :approving_id
      t.integer :approved_id

      t.timestamps null: false
    end
    add_index :project_relations, :inviting_id
    add_index :project_relations, :invited_id
    add_index :project_relations, :approving_id
    add_index :project_relations, :approved_id
    
    add_index :project_relations, [:inviting_id, :invited_id], unique: true
    add_index :project_relations, [:approving_id, :approved_id], unique: true
  end
end
