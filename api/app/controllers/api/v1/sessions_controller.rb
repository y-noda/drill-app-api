class Api::V1::SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :logged_in?, except: :login

  include SessionsHelper

  def login 
    users = User.find_by(key: 'users')
    @user = users[:save_data][params[:user_id]]

    if @user && authenticate?(@user[:password], params[:password])

      login!(@user[:userid])

      set_data = Marshal.load(Marshal.dump(users[:save_data]))

      set_data[@user[:userid]][:lastLoginDate] = DateTime.now.strftime("%Y-%m-%d")

      users.update(key: 'users', save_data: set_data)

      @user = set_data[@user[:userid]]
      @user.delete(:crownNum)
      @user.delete(:password)
      
      render json: @user
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
