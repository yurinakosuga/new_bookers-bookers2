class BooksController < ApplicationController
  before_action :correct_user, only: [:edit, :update]
  def index
    @book = Book.new 
    @books = Book.all
    @user = current_user
    
  end
  
  def update
    @book = Book.find(params[:id])
    @book.update(book_params)
    if @book.save
      flash[:notice] = 'You have updated book successfully.'
      redirect_to book_path(@book.id)
    else
      render :edit
    end  
  end
  
  def show
    @book = Book.find(params[:id])
    @user = current_user
  end
  
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = 'You have created book successfully.'
      redirect_to book_path(@book.id) 
    else
      @books = Book.all
      @user = current_user
      render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user == current_user
      render "edit"
    else
      redirect_to book_path(@book.id)
    end
  end
  
  def destroy
    @book = Book.find(params[:id])  #削除するPostImageレコードを取得
    @book.destroy#削除
    redirect_to '/books'#の一覧ページへのパス
  end
  
  private
  # ストロングパラメータ
  def book_params
    params.require(:book).permit(:title, :body, :user_id)
  end
  
end