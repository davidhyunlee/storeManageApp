# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(first_name: "Vinnie", email: "vinniecell@hotmail.com", password: "password")
User.create(first_name: "david", email: "jinetix@gmail.com", password: "password")

Store.create(name: "Vinnie Cellular", alias: "Default Store")

Carrier.create(name: "T-Mobile")
Carrier.create(name: "MetroPCS")

Category.create(name: "Mobile Phone", description: "Mobile Phone")

Setting.sales_tax = 0.09
