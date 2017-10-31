class Book < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :reviews
  has_attached_file :book_img, styles: { book_index: "300x300>", book_show: "325x475>" }, default_url: "/images/missing.png"
  validates_attachment_content_type :book_img, content_type: /\Aimage\/.*\z/
end
