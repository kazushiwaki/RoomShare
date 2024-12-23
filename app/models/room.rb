class Room < ApplicationRecord
  belongs_to :user
  has_many :reservations, dependent: :destroy # 施設の削除で、予約の削除

  # 画像を添付するための設定
  has_one_attached :image

  validates :name, :description, :address, :price_per_night, presence: true
  validates :price_per_night, numericality: { greater_than: 0 } # 1泊の料金が0より大きいこと
end
