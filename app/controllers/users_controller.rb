class UsersController < ApplicationController
  def index

  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params['id'])
    render "new"
  end

  def show
    @user = User.find(params['id'])
  end

  def follow(userid)
    user1 = current_user
    user2 = User.find(userid)
    user1.follow(user2)
    redirect_to :back
  end

  def create
    @user = User.new(users_params)
    if @user.save
      flash[:success] = "Account registered!"
      redirect_to root_path
    else
      render :new
    end
  end

  def update
    @user =User.find(params['id'])
    if @user.update(users_params)
      flash[:success] = "Account Updated!"
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end



  private

  def users_params
    params.require(:user).permit(:bio, :email, :password, :password_confirmation,:profile_picture,:username,:name)
  end
end
