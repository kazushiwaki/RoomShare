class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_id

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_id?
    current_user.present?
  end

  def authenticate_user!
    unless logged_id?
      redirect_to login_path, alert: "ログインして下さい"
    end
  end

end
