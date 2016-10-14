class ApplicationController < ActionController::Base
  include Pundit
  after_action :verify_authorized
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  # rescue_from Pundit::AuthorizationNotPerformedError, with: :authorization_required
  protect_from_forgery with: :exception
  before_filter :authenticate

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_store
  	@current_store ||= Store.find(session[:store_id]) if session[:store_id]
  end

  def set_store(store_id)
  	session[:store_id] = store_id
  end

  helper_method :current_user, :current_store, :set_store

  def authenticate
    redirect_to '/login' unless current_user
  end

  private

    def user_not_authorized
      flash[:alert] = "Access denied."
      redirect_to (request.referrer || root_path)
    end

    def authorization_required
      flash[:alert] = "Authorization is required."
    end
end
