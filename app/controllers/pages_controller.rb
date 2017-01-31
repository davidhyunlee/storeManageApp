class PagesController < ApplicationController
	def dashboard
		authorize :page, :dashboard?
		@sale_type_counts = Hash.new

		SaleType.all.each do |st|
			if st.tracked
				@sale_type_counts[st.name.to_sym] = 0
			end
		end

		@user_invoices = Invoice.where(user_id: current_user.id, created_at: Time.now.beginning_of_month.utc..Time.now.end_of_month.utc)

		@user_invoices.each do |invoice|
			invoice.line_items.each do |li|
				if li.sale_type
					@sale_type_counts[li.sale_type.name.to_sym] += 1 if li.sale_type.tracked
				end
			end
		end
	end

	def select_store
		@stores = Store.all
		authorize :page, :select_store?
		session[:store_id] = params[:format] if params[:format]
	end
end
