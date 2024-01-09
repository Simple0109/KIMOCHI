class DropMessages < ActiveRecord::Migration[7.0]  # バージョンは適宜調整してください
  def up
    drop_table :messages
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
