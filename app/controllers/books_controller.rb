class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit,:update]

  def new
  	@book = Book.new
  end

  def create
  	book = Book.new(book_params)
    book.user_id = current_user.id
  	if book.save
  	  	redirect_to books_path
  	else
  		render 'new'
  	end
  end

  def index
  	@now_month = DateTime.now
    this_month = DateTime.now.all_month
    @books = Book.where(sale_date: this_month, user_id: current_user.id).order(sale_date: :asc)
    @books_sum = Book.where(sale_date: this_month, user_id: current_user.id).sum(:money).to_s(:delimited)
    @user = User.find(current_user.id)
  end

  def index_all
    @books_all = Book.where(user_id: current_user.id).order(sale_date: :asc)
    @books_all_sum = Book.where(user_id: current_user.id).sum(:money).to_s(:delimited)
    @user = User.find(current_user.id)
  end

  def index_ago
    @ago_month = DateTime.now.ago(1.month)
    ago_months = DateTime.now.ago(1.month).all_month
    @ago_books = Book.where(sale_date: ago_months, user_id: current_user.id).order(sale_date: :asc)
    @ago_books_sum = Book.where(sale_date: ago_months, user_id: current_user.id).sum(:money).to_s(:delimited)
    @user = User.find(current_user.id)
  end

  def show
    @book = Book.find(params[:id])
    @today = DateTime.now
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    book = Book.find(params[:id])
    if book.update(book_params)
      redirect_to books_path
    else
      render 'edit'
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  private
  def book_params
  	params.require(:book).permit(:name,:money,:comment,:sale_date)
  end

  def correct_user
    book = Book.find(params[:id])
    if current_user.id != book.user_id
      redirect_to root_path
    end
  end

end
