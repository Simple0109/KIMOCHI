class AddUniqueIndexToProfiles < ActiveRecord::Migration[7.0]
  def change
    add_index :profiles, :user_id, unique: true, name: 'index_profiles_on_user_id_unique'
  end
end
