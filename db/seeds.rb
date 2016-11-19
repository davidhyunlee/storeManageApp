# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(first_name: "Vinnie", email: "vinniecell@hotmail.com", password: "password", role: 3)
User.create(first_name: "David", email: "a@a.com", password: "pass", role: 3)

Store.create(name: "Vinnie Cellular", alias: "Default Store")
Store.create(name: "Vinnie Cellular", alias: "Second Store")

Carrier.create(name: "T-Mobile")
Carrier.create(name: "MetroPCS")

Category.create(name: "Mobile Phone", description: "Mobile Phone")

PaymentType.create(name: "New Activation")
PaymentType.create(name: "Monthly Payment")

Setting.sales_tax = 0.09
Setting.mts_surcharge = 0.18
Setting.time_zone = "Pacific Time (US & Canada)"
