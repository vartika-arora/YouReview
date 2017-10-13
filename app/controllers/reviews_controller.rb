class ReviewsController < ApplicationController
  before_action :find_book
  before_action :find_review, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :edit]
  
  def new
    if current_user 
      @review = Review.where(user_id: current_user.id, book_id: params[:book_id]).first_or_initialize 
      if @review.id.present? 
        flash[:notice] = "You can't review a book more than once!"
        redirect_to book_path(@book)
      end 
    end 
  end

  def create
    @review = Review.new(review_params)
    @review.book_id = @book.id
    @review.user_id = current_user.id
    if @review.save
      redirect_to book_path(@book)
    else
      render 'new'
    end
  end

  def edit
    @review = Review.find(params[:id])
  end

  def update
    @review = Review.find(params[:id])
    if @review.update(review_params)
      redirect_to book_path(@book)
    else
      render 'edit'
    end
  end
  def destroy
    @review.destroy
    redirect_to book_path(@book)
  end

  private

    def review_params
      params.require(:review).permit(:rating, :comment)
    end
    def find_book
      @book = Book.find(params[:book_id])
    end
    def find_review
      @review = Review.find(params[:id])
    end
end
