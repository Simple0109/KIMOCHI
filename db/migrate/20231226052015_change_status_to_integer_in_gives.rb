class ChangeStatusToIntegerInGives < ActiveRecord::Migration[6.0]
  def up
    # 既存のデフォルト値を削除
    change_column_default :gives, :status, nil

    # カラムの型をintegerに変更する
    change_column :gives, :status, 'integer USING CAST(status AS integer)'

    # 新しいデフォルト値を設定する（必要に応じて適切な値に変更してください）
    change_column_default :gives, :status, 0
  end

  def down
    # ロールバック時の処理。元の型に戻す場合のコードを記述します。
    change_column :gives, :status, :string
    # 元のデフォルト値に戻す（もし元のデフォルト値があった場合）
  end
end
