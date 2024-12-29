class Room < ApplicationRecord
  belongs_to :user
  has_many :reservations, dependent: :destroy # 施設の削除で、予約の削除

  # 画像を添付するための設定
  has_one_attached :image

  validates :name, :description, :address, :price_per_night, presence: true
  validates :price_per_night, numericality: { greater_than: 0 } # 1泊の料金が0より大きいこと


  def self.search(params, user)
    # ログイン中のユーザーの施設を取得
    rooms = Room.all

    if params[:keyword].present? || params[:area].present?
      # エリア検索
      if params[:area].present? && %w[東京 大阪 京都 札幌].include?(params[:area])
        rooms = rooms.where("address LIKE ?", "#{params[:area]}%")
      end

      # キーワード検索
      if params[:keyword].present?
        keyword = params[:keyword]
        rooms = rooms.where("name LIKE ? OR description LIKE ?", "%#{keyword}%", "%#{keyword}%")
      end
    else
      rooms = rooms.where(user_id: user.id)
    end

    rooms
  end
end
