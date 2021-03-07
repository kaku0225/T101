class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    pw = Digest::SHA1.hexdigest("a#{params[:user][:password]}Z")
    @user = User.find_by(email: params[:user][:email], password: pw)
    if @user
      session[:user1111] = @user.id
      redirect_to users_tasks_path, notice:'登入成功'
    else
      redirect_to sign_in_users_path, notice: '登入失敗'
    end
  end
end