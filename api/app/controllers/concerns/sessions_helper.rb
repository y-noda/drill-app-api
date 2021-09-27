module SessionsHelper
  def authenticate?(saved_pass, sent_pass)
    saved_pass == Digest::MD5.hexdigest(sent_pass)
  end

end