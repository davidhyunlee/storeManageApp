class PagesController < ApplicationController
	before_filter :authenticate

	def dashboard
		authorize :pages, :dashboard?
	end

	def select_store
	end
end
