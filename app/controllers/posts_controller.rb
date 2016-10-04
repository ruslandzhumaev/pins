class PostsController < ApplicationController
  
  before_action :find_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  def index
  	if params[:category_id]
      @posts = Post.where(:category_id => params[:category_id]).order('created_at DESC').paginate(:page => params[:page], :per_page => 16)
    elsif params[:search]
      @posts = Post.search(params[:search]).order('created_at DESC').paginate(:page => params[:page], :per_page => 16)
    else
      @posts = Post.all.order('created_at DESC').paginate(:page => params[:page], :per_page => 16)
    end
  end

  def show
  end

  def new
  	@post = current_user.posts.build
  end

  def create
  	@post = current_user.posts.build(post_params)

  	if @post.save
  	  redirect_to @post
  	else
  	  render 'new'
  	end
  end

  def edit
  end

  def update
  	if @post.user_id == current_user.id
      if @post.update(post_params)
    	  redirect_to @post
    	else
    	  render 'edit'
    	end
    else
      redirect_to root_path
    end
  end

  def destroy
    if @post.user_id == current_user.id
      @post.destroy
      redirect_to root_path
    else
      redirect_to root_path
    end
  end

  private

  	def post_params
  	  params.require(:post).permit(:title, :text, :image, :category_id, :slug)
  	end

  	def find_post
	  @post = Post.friendly.find(params[:id])
	end  		

end
