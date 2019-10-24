class BooksController < ApplicationController
  before_action :authenticate_user!, only: [:show,:create, :edit, :update, :destroy, :index]

	def index
  	@books = Book.all
  	@book = Book.new
    @user = current_user
  end

	def new
		@books = Book.all
		@book = Book.new
	end

	def create
		@book = Book.new(book_params)
		@book.user_id = current_user.id
  	if @book.save
  		flash[:notice] = "You have creatad book successfully."
			redirect_to book_path(@book.id)
		else
			@books = Book.all
			render :new
		end
	end

	def update
		@book = Book.find(params[:id])
    @book.update(book_params)
    if @book.save
      redirect_to book_path(@book)
      flash[:notice] = "You have updated book successfully."
    else
      render :edit
    end
  end
  
  def show
  	@book1 = Book.find(params[:id])
  	@books = Book.all
  	@book = Book.new
  end

  def edit
  	@book = Book.find(params[:id])
    if @book.user_id != current_user.id
      redirect_to books_path
  end
  end

  def destroy
  	book = Book.find(params[:id])
    book.destroy
    flash[:notice] = "You have destroyed book successfully."
    redirect_to books_path
  end

	private
	  def book_params
	  	params.require(:book).permit(:title, :body, :profile_image)
	  end

end