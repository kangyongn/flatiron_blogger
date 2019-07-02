class BlogsController < ApplicationController
  before_action :get_blog, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token

  def show
  end

  def new
    @blog = Blog.new
    @students = @logged_in_user.cohort.users.where(role: 'Student')
  end

  def create
    @blog = Blog.create(blog_params)
    if @logged_in_user.role == 'TCF'
      redirect_to home_tcf_path(@logged_in_user)
    else
      redirect_to @blog
    end
  end

  def edit
    if session[:user_id] = @blog.user_id
      @blog
    else
      flash[:errors] = "Login to edit your blog"
      redirect_to login_path
    end
  end

  def update
    if @blog.update(blog_params)
      redirect_to @blog
    else
      flash[:errors] = @blog.errors.full_messages
      redirect_to edit_blog_path
    end
  end

  def destroy
    if session[:user_id] == @logged_in_user.id
      @blog.delete
      redirect_to home_student_path(@logged_in_user)
    end
  end

  private

  def get_blog
    @blog = Blog.find(params[:id])
  end

  def blog_params
    params.require(:blog).permit(:title, :content, :due_date, :user_id)
  end
end
