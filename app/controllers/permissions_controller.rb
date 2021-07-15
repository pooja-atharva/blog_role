class PermissionsController < InheritedResources::Base

  private

    def permission_params
      params.require(:permission).permit(:name, :subject_class, :action)
    end

end
