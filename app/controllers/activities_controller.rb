class ActivitiesController < ApplicationController

  before_filter :authenticate_user!, except: [:index, :show]
  
  before_filter :require_login

  def index
    @activities = Activity.all
  end

  def show
    @activity = Activity.find(params[:id])
  end

  def new
    @activity = Activity.new
  end

  def edit
    @activity = Activity.find(params[:id])
  end

  def create
    @activity = Activity.new(params[:activity])
    if @activity.save
      redirect_to @activity, notice: "Activity was successfully created."
    else
      render "new"
    end
  end

  def update
    @activity = Activity.find(params[:id])
    if @activity.update_attributes(params[:activity])
      redirect_to @activity, notice: "Activity was successfully updated."
    else
      render "edit"
    end
  end

  def destroy
    @activity = Activity.find(params[:id])
    @activity.destroy
    redirect_to activities_url
  end



  private

    def require_login
      unless current_user
        redirect_to authentications_url
      end
    end
end
