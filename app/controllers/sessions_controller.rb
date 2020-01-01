class SessionsController < ApplicationController

  include SessionsHelper

  def new
    redirect_to current_user if logged_in?
  end

  def create
    user = User.find_by_email(params[:session][:email])
    if user && user.authenticate(params[:session][:password])
    # 登录当前用户，并跳转至该用户详情页
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_back_or user
    else
      flash.now[:danger] = "登录失败，用户名/密码错误！"
      render :new
    end
  end

  def destroy
    # 登出当前用户，并跳转至登录页
    if logged_in?
      log_out
      redirect_to :login
    end
  end

  def game_start
      
      render :game
  end

end
