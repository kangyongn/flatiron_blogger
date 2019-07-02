class TcfsController < ApplicationController

  before_action :get_user, only: [:home]

  def home
    if session[:user_id] == @user.id
      @students = @user.cohort.users.where(role: 'Student')
    else session[:user_id] == nil
      flash[:errors] = ['Login to view profile homepage']
      redirect_to login_path
    end
  end

  private

  def get_user
    @user = User.find(params[:id])
  end
end
