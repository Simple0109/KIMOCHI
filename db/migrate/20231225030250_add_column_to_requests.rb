class AddColumnToRequests < ActiveRecord::Migration[7.0]
  def change
    add_column :requests, :user_uid, :string
  end
end
