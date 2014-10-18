class SessionsController < ApplicationController

  skip_filter :authenticate_user!
  respond_to :json

  SUCCESS = {success: true}
  FAILURE = {success: false, errors: ["Invalid email or password."]}

  def create
    @user = User.login(*login_params)
    if @user
      session[:user_id] = @user.id
      respond_with(SUCCESS, location: root_url)
    else
      respond_with(FAILURE, location: root_url)
    end
  end

  def destroy
    session.destroy
    head :ok
  end

  private

    def login_params
      l = params.require(:user).permit(:email, :password)
      return l[:email], l[:password]
    end

end
