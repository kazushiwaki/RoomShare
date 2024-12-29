class User < ApplicationRecord
  has_many :rooms, dependent: :destroy # ユーザーの削除で登録施設も削除
  has_many :reservations, dependent: :destroy # ユーザーの削除で、予約も削除

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true
  validates :password, presence: true, confirmation: { message: "パスワードが一致しません" }, if: :password_required?
  validates :password_confirmation, presence: true, if: :password_required?

  # パスワードの暗号化メソッド(パスワードを暗号化して保存)
  has_secure_password
  # ActiveStorrage用
  has_one_attached :image

  private

  # パスワードが必要かを判定する
  def password_required?
    new_record? || password.present?
  end
end
