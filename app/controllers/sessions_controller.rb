class SessionsController < ApplicationController
  def new
    return unless logged_in?

    redirect_to root_url
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      user_authenticated user
    else
      flash.now[:danger] = t("custom_errors.invalid_login_msg")
      render :new
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
