class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

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

  def authorize
    redirect_to '/login' unless current_user
  end
end
