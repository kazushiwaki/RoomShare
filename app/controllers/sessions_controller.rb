class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id # セッションにユーザーIDを保存
      redirect_to root_path, notice: "ログインしました！"
    else
      flash.now[:alert] = "メールアドレスまたはパスワードが間違っています。"
      render new_session_path, status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "ログアウトしました！"
  end
end
