class AddUniqueConstraintToGroupUsers < ActiveRecord::Migration[7.0]
  def change
    add_index :group_users, %i[user_id group_id], unique: true
  end
end
