class ImagesController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @images = @user.images
  end

  def show
    @image = Image.find(params[:id])
    @user = User.find(params[:user_id])
  end

  def new
    @image = Image.new

    @user = User.find(params[:user_id])
  end

  def create
    @image = Image.new(params[:image])
    @user = User.find(params[:user_id])
    
    if @image.save
      redirect_to user_image_path(@user, @image), :notice  => "Successfully created image."
    else
      render :action => 'new'
    end
  end

  def edit
    @image = Image.find(params[:id])
    @user = User.find(params[:user_id])
  end

  def update
    @image = Image.find(params[:id])
    @user = User.find(params[:user_id])
    if @image.update_attributes(params[:image])
      redirect_to user_image_path(@user, @image), :notice  => "Successfully updated image."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @image = @user.images.where(:id => params[:id])
    @image.destroy
    redirect_to images_url, :notice => "Successfully destroyed image."
  end

  private

end
