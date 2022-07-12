# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

User.delete_all
Stock.delete_all
Transaction.delete_all

User.create!(
  username: 'bhargav',
  email: 'sb.bhargav1993@gmail.com',
  password: '12345678A$',
  password_confirmation: '12345678A$'
)

puts "user has been created"

10.times do |num|
  User.first.stocks.create!(
    companyname: "Company #{num}",
    stockprice: 1000*(num+1),
    user_id: User.last.id
  )

end

puts "10 stocks are added"

Stock.all.each_with_index do |stock,idx|
  5.times do |iter|
    stock.transactions.create!(
    no_of_stocks: iter+100,
    status: "purchased"
  )
  end

  5.times do |iter|
    stock.transactions.create!(
    no_of_stocks: iter+50,
    status: "sold"
  )
  end
  
end

puts "transactions are created"