class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(email: params[:user][:email]) # 入力内容を保持
    user = User.find_by(email: params[:user][:email])

    if user&.authenticate(params[:user][:password])
      session[:user_id] = user.id # セッションにユーザーIDを保存
      flash[:notice] = "ログインしました！"
      redirect_to root_path
    else
      flash.now[:alert] = "メールアドレスまたはパスワードが間違っています。"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil
    flash.now[:notice] = "ログアウトしました！"
    redirect_to root_path
  end
end
