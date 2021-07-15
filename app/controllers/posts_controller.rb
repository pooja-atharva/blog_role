class PostsController < InheritedResources::Base
  # before_action :load_and_authorize_resource
  before_action :load_permissions # call this after load_and_authorize else it gives a cancan error
  
  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to posts_path and return
    end
    render 'new'
  end

  private

  def post_params
    params.require(:post).permit(:name, {avatars: []})
  end

end
