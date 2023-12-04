class RenameInvitePasswordToColumnToGroups < ActiveRecord::Migration[7.0]
  def change
    rename_column :groups, :invite_password, :invite_token
  end
end
