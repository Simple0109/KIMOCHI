class ChangeUserIdNotNullInGroups < ActiveRecord::Migration[7.0]
  def change
    def change
      change_column_null :groups, :user_id, false
    end
  end
end
