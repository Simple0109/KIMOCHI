class CreateRequestApprovals < ActiveRecord::Migration[7.0]
  def change
    create_table :request_approvals do |t|
      t.integer :approval_status, null: false, default: 0
      t.references :user, null: false, foreign_key: true
      t.references :request, null: false, foreign_key: true

      t.timestamps
    end
  end
end
