class Api::UsersController < Api::BaseController

  skip_before_action :is_authenticated, :only => [:create]
  before_action :set_user, except: [:create, :index]

  def index
    @users = User.all
    render json: {
        success: true,
        users: @users
      }
  end

  def create
    @user = User.new(resource_params)
    @user.password = params[:password]
    if @user.save
      json = @user
      render json: {
        success: true,
        user: json
      }
    elsif @user.errors.present?
      render json: {
        success: false,
        error: @user.errors.full_messages
      }
    else
      render json: {
        success: false,
        error: "Something went wrong, Please try again."
      }
    end
  end

  def update
    if @user
      @user.update(resource_params)
      if params[:password]
        @user.update(password: params[:password])
      end
      render json: {
        success: true,
        user: @user
      }
    else
      render json: {
        success: false,
        error: "User was not found with given email"
      }
    end
  end

  def destroy
    super
  end

  protected
    def set_user
      @user = User.find_by(id: params[:id])
      unless @user.present?
        render json: {
          success: false,
          error: "User not found."
        }
      end
    end

    def resource_params
      params.require(:user).permit(:id, :email, :first_name, :last_name)
    end
end
