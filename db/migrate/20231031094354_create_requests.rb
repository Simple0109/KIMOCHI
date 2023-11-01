class CreateRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :requests do |t|
      t.string :take, null: false
      t.datetime :execution_date
      t.string :image
      t.text :comment
      t.integer :status, null: false, default: 0

      t.timestamps
    end
  end
end
