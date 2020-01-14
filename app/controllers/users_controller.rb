class UsersController < ApplicationController

  include SessionsHelper

  before_action :request_logged, only: [:edit, :update, :index, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: [:destroy]

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    @user.data = "1"
    if @user.save
      flash[:success] = edit_account_activation_url(@user.activation_token, email: @user.email).to_s
      UserMailer.account_activation(@user).deliver_now
      redirect_to user_url(@user)
    else
      render 'new'
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "更新资料成功" + user_params.values.join(',')
      redirect_to user_url(@user)
    else
      render 'edit'
    end
  end

  def destroy
    user = User.find(params[:id])
    if current_user?(user)
      flash[:danger] = "不能删除自己"
    else
      user.destroy
      flash[:success] = "删除成功"
    end
    redirect_to users_url
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email, :password)
    end

    def request_logged
      if !logged_in?
        store_location
        flash[:danger] = "请登录后重试！"
        redirect_to "/login"
      end
    end

    def correct_user
      @user = User.find(params[:id])
      if @user != current_user
        redirect_to current_user
      end
    end

    def admin_user
      redirect_to(users_url) if !current_user.admin?
    end

end
