class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :store_current_location, :unless => :devise_controller?

  private

def store_current_location
store_location_for(:user, request.url)
end

  def require_is_admin
      if !current_user.admin?
        flash[:alert] = 'You are not admin'
        redirect_to root_path
      end
    end
end
