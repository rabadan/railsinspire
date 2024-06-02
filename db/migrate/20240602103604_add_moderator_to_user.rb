class AddModeratorToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :moderator, :boolean, default: false, null: false
    add_index :users, :moderator
  end
end
