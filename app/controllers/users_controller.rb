class UsersController < ApplicationController
  def index
    #@search = Article.search do
    #fulltext params[:search]
    #end\
    #


    if params[:search].present? 
      @users = User.search(params[:search].to_s)
    else
      @users = User.scoped
    end
    @users = @users.paginate(:per_page => 10 , :page => params[:page]).to_a
    respond_to do |format|
      format.html { render :index }
      format.js 
      format.json 
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to @user, :notice => "Successfully created user."
    else
      render :action => 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      redirect_to @user, :notice  => "Successfully updated user."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_url, :notice => "Successfully destroyed user."
  end
end
