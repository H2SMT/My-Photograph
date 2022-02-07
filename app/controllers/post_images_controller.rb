class PostImagesController < ApplicationController
  before_action :baria_user, only: [:edit, :destroy, :update]
  before_action :all_ranks, only: [:index, :search]

  def new
    @post_image = PostImage.new
  end

  def create
    @post_image = PostImage.new(post_image_params)
    @post_image.user_id = current_user.id
    if @post_image.save
      redirect_to post_images_path
    else
      render :new
    end
  end

  def index
    @post_images = PostImage.page(params[:page]).reverse_order
    # @all_ranks = PostImage.find(Favorite.group(:post_image_id).order('count(post_image_id) desc').limit(3).pluck(:post_image_id))
  end

  def show
    @post_image = PostImage.find(params[:id])
    @post_comment = PostComment.new
  end
  
  def edit
    @post_image = PostImage.find(params[:id])
  end
  
  def update
    post_image = PostImage.find(params[:id])
    post_image.update(post_image_params)
    redirect_to post_image_path(post_image)
  end

  def destroy
    @post_image = PostImage.find(params[:id])
    @post_image.destroy
    redirect_to post_images_path
  end

  def search
    @post_images = PostImage.search(params[:keyword])
    @post_images = @post_images.page(params[:page])
    # @all_ranks = PostImage.find(Favorite.group(:post_image_id).order('count(post_image_id) desc').limit(3).pluck(:post_image_id))
    @keyword = params[:keyword]
    render "index"
  end

  private

  def post_image_params
    params.require(:post_image).permit(:post_name, :image, :caption)
  end
  
  def baria_user
    unless PostImage.find(params[:id]).user.id.to_i == current_user.id
        redirect_to post_images_path(current_user)
    end
  end
  
  def all_ranks
    @all_ranks = PostImage.find(Favorite.group(:post_image_id).order('count(post_image_id) desc').limit(3).pluck(:post_image_id))
  end

end