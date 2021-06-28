class Api::CommentsController < Api::BaseController
  before_action :set_class_attributes
  before_action :set_resource, except: [:new, :create]

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
      set_resource_class_attributes(Comment)
    end

    def resource_params
      params.require(:comment).permit(:id, :body, :post_id, :user_id, :parent_id)
    end

end
