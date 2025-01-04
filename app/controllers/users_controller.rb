class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:new, :create]

  def show
    @user = current_user
  end

  def edit_account
    @user = User.find(params[:id])
  end

  def edit_profile
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id # ログイン状態にするため
      redirect_to root_path, notice: "アカウントを作成しました！"
    else
      render "new", status: :unprocessable_entity # バリデーションエラー時にエラーメッセージを表示するために記載
    end
  end

  def update_account
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "アカウント情報が更新されました！"
    else
      render "edit_account"
    end
  end

  def update_profile
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to user_path(@user), notice: "アカウント情報が更新されました！"
    else
      render "edit_profile"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile, :email, :password, :password_confirmation, :image)
  end
end
