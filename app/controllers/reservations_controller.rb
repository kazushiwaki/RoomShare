class ReservationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  before_action :set_reservation, only: [:edit, :update, :destroy]
  before_action :set_room

  def index
    if @room.present?
      @reservations = @room.reservations.includes(:user)
      @room = Room.all
    else
      @reservations = current_user.reservations.includes(:room)
    end
  end

  def new
    @room = Room.find(params[:room_id])  # 予約画面に遷移する際、`room_id` を渡す
    @reservation = Reservation.new
  end

  def confirm
    @room = Room.find(params[:reservation][:room_id])
  
    if params[:reservation][:id].present?
      @reservation = Reservation.find(params[:reservation][:id])
      @reservation.assign_attributes(reservation_params)
    else
      @reservation = Reservation.new(reservation_params)
      @reservation.user = current_user
    end
  
    if @reservation.valid?
      render :confirm
    else
      action = @reservation.new_record? ? :new : :edit
      render action
    end
  end

  def create
    @room = Room.find(params[:reservation][:room_id])
  
    if params[:reservation][:id].present?
      # 既存の予約を取得して更新
      @reservation = Reservation.find(params[:reservation][:id])
      @reservation.assign_attributes(reservation_params)
    else
      # 新しい予約を作成
      @reservation = current_user.reservations.build(reservation_params)
    end
  
    if @reservation.save
      redirect_to reservations_path, notice: '予約が確定しました。'
    else
      render :confirm
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
    @reservation = Reservation.find(params[:id])
    @reservation.destroy
    flash[:notice] = "予約が削除されました"
    render json: { message: "施設が削除されました", type: "notice" }, status: :ok
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
