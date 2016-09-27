json.array!(@invoices) do |invoice|
  json.extract! invoice, :id, :customer_id, :user_id, :store_id, :total
  json.url invoice_url(invoice, format: :json)
end
