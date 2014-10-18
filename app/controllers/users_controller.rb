class UsersController < ApplicationController

  skip_filter :authenticate_user!
  respond_to :json

  def show
    respond_with(User.find(params[:id]))
  end

  def create
    @user = User.new(user_params)
    @user.save
    respond_with(@user, except: [:password_hash, :password_salt])
  end

  private

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end

end
