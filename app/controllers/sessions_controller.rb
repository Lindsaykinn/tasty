class SessionsController < ApplicationController
  before_action :redirect_if_logged_in, except: [:destroy]

  def new
    @user = User.new
  end

  def create 
    @user = User.find_by_email(params[:email])

    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      flash.now[:notice] = "Invalid email or password"
      render :new
    end
  end

  def omniauth
    user = User.find_or_create_by(provider: auth["provider"], uid: auth["uid"]) do |user|
      user.name = auth["info"]["name"]
      user.password = SecureRandom.hex(10)
      user.email = auth["info"]["email"]
  end
    if user.valid?
      session[:user_id] = user.id
      redirect_to recipes_path
    else
      redirect_to login_path
    end
  end    


  def destroy 
    session.clear
    redirect_to '/login'
  end

  private

  def auth
    request.env['omniauth.auth']
  end

end

end