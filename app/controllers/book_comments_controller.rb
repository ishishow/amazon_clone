class BookCommentsController < ApplicationController
  before_action :authenticate_user!
  def create    
    @book = Book.find(params[:book_id])
    @book_new = Book.new
    @comment = @book.book_comments.new(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      flash[:success] = "Comment was successfully created."
      # redirect_to book_path(@book)
    else
      @comments = BookComment.where(book_id: @book.id)
      render '/books/show'
    end
  end

  def destroy
    @comment = BookComment.find(params[:id])
    @comment.destroy
    # redirect_to request.referer
  end

  private
  def comment_params
    params.require(:book_comment).permit(:comment)
  end
end
