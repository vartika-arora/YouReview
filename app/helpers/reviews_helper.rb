module ReviewsHelper

    def has_review_for_this_book(user,book)
        Review.where('user_id= ? AND book_id= ?',user.id,book.id).count > 0 ? true : false

    end
end
