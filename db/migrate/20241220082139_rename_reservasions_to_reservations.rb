class RenameReservasionsToReservations < ActiveRecord::Migration[6.1]
  def change
    rename_table :reservasions, :reservations
  end
end
