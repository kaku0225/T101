class RegistrationsController < ApplicationController
  def new
    @user = User.new
  end

  # 測試用

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_path, notice: '註冊成功'
    else
      render :new
    end
  end

  private
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :nickname)
    end
end