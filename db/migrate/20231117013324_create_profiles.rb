class CreateProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :profiles do |t|
      t.string :name, null: false, default: ''
      t.string :avatar
      t.integer :role, null: false, default: 0
      t.text :description
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
