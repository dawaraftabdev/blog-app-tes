class Api::BaseController < ApplicationController
  attr_accessor :resource_class, :resource_params, :custom_url
  before_action :is_authenticated

  def index
    @resources = self.resource_class.all
  end

  def new
    @resource = self.resource_class.new
  end

  def create
    @resource = self.resource_class.new self.resource_params
    self.send_resource(@resource)
  end

  def show
  end

  def edit
  end

  def update
    if @resource
      @resource.update self.resource_params
      self.send_resource(@resource)
    end
  end

  def destroy
    if @resource.destroy
      render json: {
        success: true,
        message: "#{self.resource_class} destroyed sucessfully"
      }
    end
  end

  protected

  def set_resource_class_attributes(klass)
    self.resource_class = klass
  end

  def set_resource_params_attributes(resource_params={})
    self.resource_params = resource_params
  end

  def set_resource
    @resource = self.resource_class.find_by(id: params[:id])
    unless @resource
      render json: {
        success: false,
        error: "#{self.resource_class.name} not found"
      }
    end
  end

  def set_custom_url(custom_url)
    self.custom_url = custom_url
  end


  def send_resource(resource)
    if resource.save
        render json: {
          success: true,
          data: resource
        }
      elsif resource.errors.present?
        render json: {
          success: false,
          error: resource.errors.full_messages.to_sentence
        }
      else
        render json: {
          success: false,
          error: "Something went wrong, Please try again."
        }
      end
  end

  private

    def render_unauthenticated 
      self.headers['WWW-Authenticate'] = 'Token realm="Application"'
      render json: {
        :success => false,
        :error => "Un authorized",
        }, status: 401
    end

    def is_authenticated
      authenticate_token || render_unauthenticated
    end

    def authenticate_token
      if current_user
        @user = current_user
      else
        authenticate_with_http_token do |token, options|
          @user = User.joins(:sessions).find_by("sessions.api_token"=> token) rescue nil
          if @user
            sign_in @user
          end
        end
      end
      @user
    end

    def render_unauthorized
      render json: {
        :success => false,
        :error => "Un authorized"
      }
    end

end
