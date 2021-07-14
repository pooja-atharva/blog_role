class PostsController < InheritedResources::Base
  # before_action :load_and_authorize_resource
  before_action :load_permissions # call this after load_and_authorize else it gives a cancan error

  private

    def post_params
      params.require(:post).permit(:name)
    end

end
