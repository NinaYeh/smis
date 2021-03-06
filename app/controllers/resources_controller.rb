class ResourcesController < ApplicationController
  before_action :set_resource, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @resources = Resource.where(published: true)
  end

  def new
    @resource = Resource.new
  end

  def create
    @resource = current_user.resources.new(resource_params)
    @resource.published = false;
    if @resource.save
      redirect_to @resource, notice: '您的分享的資源已送出，經確認後就會分享給大家囉！'
    else
      render :new
    end
  end

  def show
    @comments = @resource.resource_comments.all
    @comment = @resource.resource_comments.build
  end

  private
    def set_resource
      @resource = Resource.find(params[:id])
    end

    def resource_params
      params.require(:resource).permit(:title, :url, :file, :description, :published, :user_id)
    end
end
