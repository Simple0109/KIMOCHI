class CreateGives < ActiveRecord::Migration[7.0]
  def change
    create_table :gives do |t|
      t.string :content
      t.datetime :deadline
      t.string :status, default: 0
      t.references :request, null: false, foreign_key: true

      t.timestamps
    end
  end
end
