class UsersController < ApplicationController

before_action :authenticate_user!
before_action :authenticate_user1, only: [:edit, :update]


	def index
		@users = User.all
		@book = Book.new
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)

		if @user.save
    	flash[:success] = 'Welcome! You have signed up successfully.'
    	redirect_to @user
    end
  end

	def show
		@users = User.all
		@book = Book.new
		@user = User.find(params[:id])
	end

	def edit
			@user = User.find(params[:id])
	end



	def update
		@user = User.find(params[:id])
		@user.update(user_params)
		if @user.save
			redirect_to user_path(@user)
			flash[:notice] = "You have updated user successfully."

		else 
			render :edit
		end
	end

  def books
    @users = User.all
    @book = Book.new
    @book = Book.all
  end

  private
  def user_params
   	params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def authenticate_user1
		if params[:id].to_i != current_user.id
			redirect_to user_path(current_user)
		end
	end

end