class AddToColumnRequest < ActiveRecord::Migration[7.0]
  def change
    add_column :requests, :give1, :string, null: false
    add_column :requests, :give2, :string
    add_column :requests, :give3, :string
  end
end
