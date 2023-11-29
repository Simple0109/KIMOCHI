class CreateRequestUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :request_users do |t|
      t.references :request, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :approval_status, default: 0

      t.timestamps
    end
    add_index :request_users, [:request_id, :user_id], unique: true
  end
end
