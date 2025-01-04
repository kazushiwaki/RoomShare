class HomeController < ApplicationController
  def index
    # ユーザーがログインしている場合、@userにユーザー情報を設定
    if session[:user_id]
      @user = User.find(session[:user_id])
    end
  end
end
