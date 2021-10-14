class UsersController < ApplicationController
  def index
    @user = User.new
    render :new
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find_by id: params[:id]
    if @user.nil?
      render :not_found_404
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = t("pages.welcome")
      redirect_to @user
    else
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit(:name,
                                 :email,
                                 :password,
                                 :password_confirmation)
  end

  def not_found_404
  end
end
