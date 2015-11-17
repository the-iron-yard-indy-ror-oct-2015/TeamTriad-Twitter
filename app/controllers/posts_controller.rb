class PostsController < ApplicationController

  before_action :require_user, only: [:new, :create, :edit, :update, :destroy]

  def index
  end

  def create
    @post = Post.new(post_params)
    @post.update(user_id: current_user.id)
    if @post.save
      flash[:success] = "Your Post Was a Success!"
      redirect_to root_path
    else
      render :new
    end
  end

  def new
    @posts = Post.all
    @post = Post.new
  end
  def edit
    @post = Post.find(params[:id])
    @post.save
    render :new
  end

  def update
   @post = Post.find(params[:id])
   if @post.update(post_params)
     redirect_to @post
   else
     render "new"
   end
 end

def show
    @posts = Post.find(params[:id])
    render "post"
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    Post.all
    redirect_to root_path
    @post.save

  end


end
