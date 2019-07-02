class ApplicationController < ActionController::Base
  before_action :status

  def status
    @logged_in = !!session[:user_id]
    @logged_in_user = User.find(session[:user_id]) if @logged_in
  end

  def login_user(user)
    session[:user_id] = user.id
  end
end
