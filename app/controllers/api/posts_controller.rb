class Api::PostsController < Api::BaseController
  before_action :set_class_attributes
  before_action :set_resource, except: [:new, :create, :index]

  def index
   @resources = Post.all.includes(:comments, :user)
  end

  def create
    super
  end

  def update
    super
  end

  def destroy
    super
  end

  protected

  def set_class_attributes
    set_resource_class_attributes(Post)
  end

  def resource_params
    params.require(:post).permit(:id, :title, :sub_title, :user_id)
  end

end