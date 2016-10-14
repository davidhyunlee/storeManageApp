class PagesController < ApplicationController
	def dashboard
		authorize :page, :dashboard?
	end

	def select_store

	end
end
