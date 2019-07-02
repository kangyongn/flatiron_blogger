class UsersController < ApplicationController

  skip_before_action :verify_authenticity_token

  def new
    @user = User.new
    @cohorts = Cohort.all
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login_user(@user)
      if @user.role == 'TCF'
        redirect_to home_tcf_path(@user)
      else
        redirect_to home_student_path(@user)
      end
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to new_user_path(@user.id)
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :username, :password, :password_confirmation, :role, :cohort_id)
  end

end
