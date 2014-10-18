# Taken from below and modified:
# http://natashatherobot.com/devise-rails-sign-in/
class SessionsController < Devise::SessionsController

  def create
    resource = warden.authenticate!(scope: resource_name, recall: "#{controller_path}#respond_to_failure")
    sign_in_and_redirect(resource_name, resource)
  end

  # Override sign in to not redirect
  def sign_in_and_redirect(resource_or_scope, resource=nil)
    scope = Devise::Mapping.find_scope!(resource_or_scope)
    resource ||= resource_or_scope
    sign_in(scope, resource) unless warden.user(scope) == resource
    respond_to_success
  end

  # Override sign out to not redirect
  def respond_to_on_destroy
    respond_to_success
  end

  def respond_to_failure
    render json: {success: false, errors: ["Login failed."]}
  end

  def respond_to_success
    render json: {success: true}
  end
  
end
