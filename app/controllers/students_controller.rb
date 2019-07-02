class StudentsController < ApplicationController

  before_action :get_user, only: [:home, :show, :edit, :update]

  def home
    if session[:user_id] == @user.id
      @tcfs = @user.cohort.users.where(role: 'TCF')
      @students = @user.cohort.users.where(role: 'Student')
      @blogs = @user.blogs
    else session[:user_id] == nil
      flash[:errors] = ['Login to view profile homepage']
      redirect_to login_path
    end
  end

  def show
  end

  def edit
    @cohorts = Cohort.all
    unless @logged_in_user.role == 'TCF' && @logged_in_user.cohort == @user.cohort
      redirect_to home_tcf_path(@logged_in_user)
    end
  end

  def update
    @user.update(student_params)
    redirect_to home_tcf_path(@logged_in_user)
  end

  private

  def get_user
    @user = User.find(params[:id])
  end

  def student_params
    params.require(:student).permit(:cohort_id)
  end
end
