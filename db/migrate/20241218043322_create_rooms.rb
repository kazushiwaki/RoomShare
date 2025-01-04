class CreateRooms < ActiveRecord::Migration[6.1]
  def change
    create_table :rooms do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.string :address, null: false
      t.integer :price_per_night, null: false
      t.string :image
      t.references :user, null: false, foreign_key: true # userテーブルと関連付けるための外部キー設定

      t.timestamps
    end
  end
end
