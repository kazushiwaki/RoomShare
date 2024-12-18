class CreateReservasions < ActiveRecord::Migration[6.1]
  def change
    create_table :reservasions do |t|
      t.date :check_in_date, null: false
      t.date :check_out_date, null: false
      t.integer :total_price
      t.integer :guest_count, null: false
      t.references :user, null: false, foreign_key: true
      t.references :room, null: false, foreign_key: true

      t.timestamps
    end
  end
end
