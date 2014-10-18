class ApplicationController < ActionController::Base

  rescue_from Exception, with: :handle_exception
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  respond_to :json

  before_action :authenticate_user!

  LOGIN = {unathenticated: "You must login before accessing any data."}

  def authenticate_user!
    if session[:user_id]
      current_user # Fetch current user
    else
      respond_with(LOGIN, location: sign_in_url, status: :unauthorized)
    end
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def handle_exception(exception)
    render json: {errors: {exception.class.name.underscore => exception.message}}, status: :internal_error
  end

  def not_found(exception)
    render json: {errors: {not_found: "Yeah, about that... #{exception}"}}
  end

end
