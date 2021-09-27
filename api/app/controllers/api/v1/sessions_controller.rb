class Api::V1::SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :logged_in?, except: :login

  include SessionsHelper

  def login 
    users = User.find_by(key: 'users')
    @user = users[:save_data][params[:user_id]]

    if @user && authenticate?(@user[:password], params[:password])

      login!(@user[:userid])
      
      render json: { logged_in: true, user: @user }
    else
      render json: { status: 401, errors: '認証に失敗しました。' }
    end

  end

  def logout 
    session.delete(:user_id)
    @current_user = nil
    render json: { status: 200, logged_out: true }
  end

end
