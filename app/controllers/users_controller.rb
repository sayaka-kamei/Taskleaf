class UsersController < ApplicationController
  before_action :require_user, only: [:show] 
  skip_before_action :login_required, only: [:new, :create]

  def new
    @user = User.new
    if logged_in?
      flash[:notice] = "ユーザー登録済みです"
      redirect_to tasks_path
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user.id)
    else
      render :new
    end    
  end
  
  def show
    @user = User.find(params[:id])
    @tasks = current_user.tasks.all
  end

  private



  def user_params
    params.require(:user).permit(:name, :email, :password,
                                  :password_confirmation)
  end
  
  def admin_user
    unless current_user.admin?
      flash[:notice] = '管理者以外はアクセスできません'
      redirect_to tasks_path
    end
  end
  
  def require_user
    if current_user.id != params[:id].to_i
      flash[:notice] = "権限がありません"
      redirect_to tasks_path  
    end  
  end
end
