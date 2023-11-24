class AddInvitePasswordToGroup < ActiveRecord::Migration[7.0]
  def change
    add_column :groups, :invite_password, :string, unique: true
  end
end
