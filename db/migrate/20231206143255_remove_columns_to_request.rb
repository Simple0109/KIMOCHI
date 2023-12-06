class RemoveColumnsToRequest < ActiveRecord::Migration[7.0]
  def change
    remove_column :requests, :give1, :string
    remove_column :requests, :give2, :string
    remove_column :requests, :give3, :string
  end
end
