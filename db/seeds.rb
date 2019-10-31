# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

categories_names = ["Fantasy", "Technology", "Biography", "Fiction"]
categories_names.each do |category_name|
  Category.find_or_create_by(name: category_name)
end
puts 'Categories seeded.'

user_1 = User.where(email: 'user_1@example.org').first_or_create!(
  password: 'test123',
  password_confirmation: 'test123'
)

user_2 = User.where(email: 'user_2@example.org').first_or_create!(
  password: 'test123',
  password_confirmation: 'test123'
)
puts 'Users seeded.'

categories = Category.first(10)
(0..2).to_a.each do |category_index|
  category = categories[category_index]
  (1..3).to_a.each do |number|
    book = Book.where(title: "Book #{number}", category_id: category.id).first_or_create!(
      description: "Description of Book in category #{category.name}",
      author: 'Author of Book',
      user: user_1
    )

    if book.reviews.empty?
      book.reviews.create([
        { rating: rand(5), comment: 'Comment for Book', user: user_1 },
        { rating: rand(5), comment: 'Comment for Book', user: user_2 }
      ])
    end
  end
end
puts 'Books and Reviews seeded.'
