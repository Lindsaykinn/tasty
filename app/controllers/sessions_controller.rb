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

  def omniauth #if they are logging in with oauth
    user = User.find_or_create_by(provider: auth["provider"], uid: auth["uid"]) do |user|
        user.email = auth["info"]["email"]
        user.password = SecureRandom.hex(15)
        user.name = auth["info"]["name"]
        end
    if user.valid? #if the user exists then I want to save them into my session
        session[:user_id] = user.id  
        redirect_to user_path(user)
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

