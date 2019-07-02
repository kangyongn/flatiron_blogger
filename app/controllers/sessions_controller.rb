class SessionsController < ApplicationController

  skip_before_action :verify_authenticity_token

  def new
    if @logged_in
      if @logged_in_user.role == "TCF"
        redirect_to home_tcf_path(@logged_in_user)
      else
        redirect_to student_tcf_path(@logged_in_user)
      end
    end
  end

  def create
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      login_user(@user)
      if @user.role == 'TCF'
        redirect_to home_tcf_path(@user)
      else
        redirect_to home_student_path(@user)
      end
    else
      flash[:errors] = ['Incorrect username or password']
      redirect_to login_path
    end
  end

  def destroy
    reset_session
    redirect_to login_path
  end

end
