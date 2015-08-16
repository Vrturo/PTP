helpers do
  def current_user
    return session[:name]
  end

  def login(user)
    session[:name] = user
  end

  def logged_in?
    session[:name] == !nil?
  end

  def log_out
    session[:user_id] = nil
  end
end
