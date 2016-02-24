class BaseController < ApplicationController
  helper_method :current_collection, :current_object
  before_action :authenticate_user!
  before_filter :verify_admin

  def index
  end

  def new
    @current_object = collection_scope.new
  end

  def create
    @current_object = collection_scope.create(object_params)
    if @current_object.save
      respond_to do |f|
        f.html do
          flash[:success] = t('flash.successfully_created')
          redirect_to url_after_create
        end
        f.json
      end
    else
      flash[:danger] = t('flash.failure_created')
      render 'new'
    end
  end

  def destroy
    current_object.destroy
    respond_to do |f|
      f.html do
        flash[:success] = t('flash.successfully_destroyed')
        redirect_to url_after_destroy
      end
      f.json
    end
  end

  def edit
  end

  def update
    if current_object.update(object_params)
      respond_to do |f|
        f.html do
          flash[:success] = t('flash.successfully_updated')
          redirect_to url_after_update
        end
        f.json
      end
    else
      respond_to do |f|
        f.html do
          render action: :edit
        end
        f.json
      end
    end
  end

  private

  def url_after_create
    #request.env['HTTP_REFERER'] ||
    url_for(action: :index)
  end

  def url_after_update
    url_for(action: :show)
  end

  def url_after_destroy
    url_for(action: :index)
  end

  # alias url_after_update url_after_create
  # alias url_after_destroy url_after_create

  def collection_scope
    # You should implement it in your controller
  end

  def object_params
    # You should implement it in your controller
  end

  def current_collection
    @collection ||= collection_scope.page(params[:page])
  end

  def current_object
    @current_object ||= collection_scope.find(params[:id])
  end

  def verify_admin
    # redirect_to root_url unless current_user.role == '平台管理者' ||
    # current_user.role == '學校管理者' || current_user.role == 'Developer'
  end
end
