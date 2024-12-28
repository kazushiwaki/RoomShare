class RoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def index
    @rooms = Room.search(params, current_user)
  end

  def new
    @room = current_user.rooms.new
  end

  def show
    @room = current_user.rooms.find(params[:id])
  end

  def create
    @room = current_user.rooms.new(room_params)
    if @room.save
      redirect_to rooms_path, notice: "施設が登録されました"
    else
      render "new"
    end
  end

  def edit
    @room = current_user.rooms.find(params[:id])
  end

  def update
    @room = current_user.rooms.find(params[:id])
    if @room.update(room_params)
      redirect_to rooms_path, notice: "施設情報が更新されました"
    else
      render "edit"
    end
  end

  def destroy
    @room = current_user.rooms.find(params[:id])
    @room.destroy
    redirect_to rooms_path, notice: "施設が削除されました"
  end

  private

  def room_params
    params.require(:room).permit(:name, :description, :address, :price_per_night, :image)
  end

  def set_user
    @user = current_user
  end
end
