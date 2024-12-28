class ReservationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  before_action :set_reservation, only: [:edit, :update, :destroy]
  before_action :set_room

  def index
    if @room.present?
      @reservations = @room.reservations.includes(:user)
    else
      @reservations = current_user.reservations.includes(:room)
    end
  end

  def new
    @room = Room.find(params[:room_id])  # 予約画面に遷移する際、`room_id` を渡す
    @reservation = Reservation.new
  end

  def confirm
    @reservation = current_user.reservations.new(reservation_params)
    @room = Room.find_by(id: params[:reservation][:room_id])

    if @room.nil?
      flash[:alert] = "指定された施設が見つかりません"
      redirect_to rooms_path
      return
    end

    unless @reservation.valid?
      flash.now[:alert] = "入力内容に誤りがあります"
      render action: params[:reservation][:id].present? ? :edit : :new
    end
  end

  def create
    # room_id をフォームから受け取るため、params[:room_id] が有効かを確認
    @room = Room.find_by(id: params[:reservation][:room_id])  # reservationのパラメータ内にroom_idが含まれていることを確認

    if @room.nil?
      flash[:alert] = "指定された施設が見つかりません"
      redirect_to rooms_path
      return
    end

    # フォームから送信された予約を作成
    @reservation = current_user.reservations.new(reservation_params)

    if @reservation.save
      redirect_to reservations_path, notice: '予約が登録されました'
    else
      render :new
    end
  end

  def show
    @reservation = Reservation.find(params[:id])
  end

  def edit
    puts "Reservation: #{@reservation.inspect}"
    puts "Room: #{@room.inspect}"
  end

  def update
    if @reservation.update(reservation_params)
      redirect_to reservations_path, notice: '予約が更新されました'
    else
      render :edit
    end
  end

  def destroy
    @reservation.destroy
    redirect_to reservations_path, notice: '予約が削除されました'
  end

  private

  def set_user
    @user = current_user
  end

  def set_room
    # ここで@roomを取得することで、ビューでその施設名が表示されるようにする
    @room = Room.find_by(id: params[:room_id]) || @reservation&.room
  end

  def set_reservation
    @reservation = current_user.reservations.find(params[:id])
  end

  def reservation_params
    params.require(:reservation).permit(:check_in_date, :check_out_date, :guest_count, :room_id)
  end
end
