class ReportsController < ApplicationController
	def sales
		authorize :report, :sales?
		redirect_to reports_sales_path and return if params[:date] == ""
		@selected_date = Date.parse(params[:date]) if params[:date]
		@selected_date = DateTime.now unless params[:date]
		@invoices = Invoice.where(store_id: current_store.id, created_at: @selected_date.in_time_zone(Setting.time_zone).beginning_of_day..@selected_date.in_time_zone(Setting.time_zone).end_of_day)
		@total = 0
		@payments = Payment.where(store_id: current_store.id, created_at: @selected_date.in_time_zone(Setting.time_zone).beginning_of_day..@selected_date.in_time_zone(Setting.time_zone).end_of_day)
		@payments_total = 0

		@invoices.each do |i|
			@total += i.total
		end

		@payments.each do |p|
			@payments_total += p.amount
		end
	end

	def performance
		authorize :report, :performance?
		tracked_sale_types = []
		@counts = Hash.new

		SaleType.where(tracked: true).each do |st|
			tracked_sale_types << st.name
		end

		tracked_sale_types.each do |tst|
			@counts[tst.to_sym] = 0
		end

		@invoices = Invoice.where(user_id: 2, created_at: Time.now.beginning_of_month..Time.now.end_of_month)

		@invoices.each do |i|
			i.line_items.each do |li|
				if li.sale_type
					@counts[li.sale_type.name.to_sym] += 1 if li.sale_type.tracked
				end
			end
		end
	end

	def payments
		authorize :report, :payments?
		@selected_date = Date.parse(params[:date])
		@payments = Payments.where(created_at: selected_date.beginning_of_day..selected_date.end_of_day)
	end
end
