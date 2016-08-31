class SessionsController < ApplicationController
  def new
  end

  def create
    #session is a hash stored in the params hash
    #email & password are objects in the hash i.e. 2d array somewhat
    user = User.find_by(email: params[:session][:email].downcase)
    # user exists and authentication succeeds
    if user && user.authenticate(params[:session][:password])
      #adds user_id to sessions hash
      log_in user
      remember user
      redirect_to user
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end

  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
