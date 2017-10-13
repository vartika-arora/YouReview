class Review < ApplicationRecord
  belongs_to :book
  belongs_to :user

  # This does the magic for the multiple validation
   validates_uniqueness_of :user_id, :scope => :book_id, :message=>"You can't review a book more than once", on: 'create'
end
