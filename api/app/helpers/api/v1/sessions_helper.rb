module Api::V1::SessionsHelper


  
  def authenticate?(saved_password, sent_password)
    saved_password == BCrypt::Password.create(sent_password)
  end
end
