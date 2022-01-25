class BooksController < ApplicationController

    def create
        @book = Book.new(book_params)
        @new_book = Book.new
        @book.user_id = current_user.id
        @book.save
        redirect_to book_path(@book.id)
    end

    def show
        @book = Book.find(params[:id])
        @user = @book.user
        @new_book = Book.new

    end

    def edit
        @book = Book.find(params[:id])
        if @book.user != current_user
            redirect_to books_path
        end
    end

    def index
        @books = Book.all
        @new_book = Book.new
        @user = current_user
    end

    def destroy
        @book = Book.find(params[:id])
        @book.destroy
        redirect_to books_path
    end
    def update
        @book = Book.find(params[:id])
        if @book.update(book_params)
            redirect_to book_path(@book.id)
            flash[:notice] = "You have updated book successfully"
        else
        render :edit
        end
    end

private

  def book_params
    params.require(:book).permit(:title, :body)
  end

end
