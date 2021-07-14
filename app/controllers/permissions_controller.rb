class PermissionsController < InheritedResources::Base

  private

    def permission_params
      params.require(:permission).permit(:subject_class, :action)
    end

end
