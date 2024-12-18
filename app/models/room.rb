class Room < ApplicationRecord
  belongs_to :user
  has_many :reservasions, dependent: :destroy # 施設の削除で、予約の削除

  validates :name, description, :address, :price_per_night, presence: true
  validates :price_per_nightm, numericality: { greater_than: 0 } # 1泊の料金が0より大きいこと
end
