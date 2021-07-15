class RolesController < InheritedResources::Base
  #devise so that only logged-in user can access
  before_action :authenticate_user!
  
  #only user with super admin role can access
  before_action :is_super_admin?

  def index
    #you dont want to set the permissions for Super Admin.
    @roles = Role.all
    # .keep_if{|i| i.name != "Super Admin"}
  end
 
  def show
    @role = Role.find(params[:id])
    @permissions = @role.permissions
  end

  def new
    @permissions = Permission.all
    @role = Role.new
  end

  def create
    @role = Role.new(role_params)
    @role.permissions = []
    @role.set_permissions(params[:permissions]) if params[:permissions]
    if @role.save
      redirect_to roles_path and return
    end
    @permissions = Permission.all.keep_if{|i| ["Part"].include? i.subject_class}.compact
    render 'new'
  end

  def edit
    @role = Role.find(params[:id])
    @permissions = Permission.all
  end

  def update
    @role = Role.find(params[:id])
    # permission = Permission.find_by(id: params[:role][:permission_id])
    @role.set_permissions([params[:role][:permission_id]]) if params[:role][:permission_id]
    if @role.save
      redirect_to roles_path and return
    end
    @permissions = Permission.all.keep_if{|i| ["Part"].include? i.subject_class}.compact
    render 'edit'
  end

  private

  def role_params
    params.require(:role).permit(:name)
  end

  def is_super_admin?
    redirect_to root_path and return unless current_user.admin?
  end
end
