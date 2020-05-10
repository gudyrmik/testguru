class SessionsController < ApplicationController

  def new; end

  def create
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      cookies[:init_path] = root_path if cookies[:init_path].nil?
      redirect_to cookies[:init_path]
      cookies[:init_path] = nil
    else
      flash.now[:alert] = 'Entered credentials are not valid'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

end
