class ApplicationController < ActionController::Base
  before_action :logged_in?

  def login!(user_id)
    session[:user_id] = user_id
  end

  def current_user
    users = User.find_by(key: 'users')
    user = users[:save_data][session[:user_id]]
    @current_user ||= user if session[:user_id]
  end

  def logged_in?
    if current_user.nil?
      render json: { status: 401, errors: '認証に失敗しました。' }
    end
  end
  

end
