class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :check_in_date, :check_out_date, :guest_count, presence: true
  validates :guest_count, numericality: { greater_than: 0 }

  # カスタムバリデーション
  validate :check_in_date_must_be_today_or_future
  validate :check_out_date_must_be_after_check_in_date

  private

  def check_in_date_must_be_today_or_future
    if check_in_date.present? && check_in_date < Date.today
      errors.add(:check_in_date, "本日以降の日付を選択して下さい")
    end
  end

  def check_out_date_must_be_after_check_in_date
    if check_in_date.present? && check_out_date.present? && check_out_date <= check_in_date
      errors.add(:check_out_date, "チェックイン日より後の日付を選択して下さい")
    end
  end
end
