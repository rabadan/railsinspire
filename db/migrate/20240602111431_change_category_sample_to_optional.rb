class ChangeCategorySampleToOptional < ActiveRecord::Migration[7.0]
  def change
    change_column_null :samples, :category_id, true
  end
end
