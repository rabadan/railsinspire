class AddStateToSample < ActiveRecord::Migration[7.0]
  def change
    add_column :samples, :state, :string, default: 'created', null: false
    add_index :samples, :state
  end
end
