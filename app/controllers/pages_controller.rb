class PagesController < ApplicationController
	def dashboard
		authorize :page, :dashboard?
	end

	def select_store
		@stores = Store.all
		authorize :page, :select_store?
		session[:store_id] = params[:format] if params[:format]
	end
end
