class CohortsController < ApplicationController

  before_action :get_cohort, only: [:show, :edit, :update]

  def show
    @tcfs = @cohort.users.where(role: 'TCF')
    @students = @cohort.users.where(role: 'Student')
  end

  def new

  end

  def create
  end

  def edit
    unless @logged_in_user.role == 'TCF' && @logged_in_user.cohort.id == @cohort.id
      flash[:errors] = ['Not authorized to make changes']
      redirect_to @cohort
    end
  end

  def update
    @cohort.update(cohort_params)
    redirect_to @cohort
  end

  private

  def get_cohort
    @cohort = Cohort.find(params[:id])
  end

  def cohort_params
    params.require(:cohort).permit(:name, :mod)
  end
end
