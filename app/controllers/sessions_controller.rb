class SessionsController < ApplicationController

  include SessionsHelper
  include RglHelper

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
    @micropost = current_user.microposts.build
    @feed_items = current_user.feed
    @user = current_user
    #@lvl = lvl(current_user.level)
    #current_user.update_attributes(user_params)
    render :game
  end

  def level_judge
    #flash.now[:danger] = current_user.data
    params[:session].delete("commit")
    params[:session].values.each do |v|
      v = v.to_i
      unless v > 0 && v <= vertices(current_user.level)
        flash.now[:danger] = "请正确输入顶点号码。" 
        game_start
        return
      end
    end
    g = lvl(current_user.level)
    params[:session].values.count.downto(0) do |i|
      j = (i-1 < 0) ? params[:session].values.count : i-1
      g.remove_edge params[:session].values[i].to_i, params[:session].values[j].to_i
    end
    if g.edges.count == 0
      current_user.next_level
      render :success
    else
      flash.now[:danger] = "过关失败，还有#{g.edges}没有走到。"
      game_start
    end
  end

  def xuanze
    render :chongzhi
  end

  def chongzhi
    if params[:session][:level].to_i > 0 && params[:session][:level].to_i < 8
      current_user.chongzhi(params[:session][:level].to_i)
      redirect_to current_user
    else
      flash.now[:danger] = "请输入正确的关卡号。"
    end
  end

end
