class Users::RegistrationsController < Devise::RegistrationsController
    def build_resource(hash=nil)
        hash[:uid] = User.create_unique_string
        super
    end
    
    def update
        self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
        prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)
     
        if current_user.provider == "facebook" || current_user.provider == "twitter"
        if resource.update_without_current_password(account_update_params)
          yield resource if block_given?
          if is_flashing_format?
            flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ?
              :update_needs_confirmation : :updated
            set_flash_message :notice, flash_key
          end
          sign_in resource_name, resource, :bypass => true
          respond_with resource, :location => after_update_path_for(resource)
        else
          clean_up_passwords resource
          respond_with resource
        end
        else
        if update_resource(resource, account_update_params)
          yield resource if block_given?
          if is_flashing_format?
            flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ?
              :update_needs_confirmation : :updated
            set_flash_message :notice, flash_key
          end
          sign_in resource_name, resource, :bypass => true
          respond_with resource, :location => after_update_path_for(resource)
        else
          clean_up_passwords resource
          respond_with resource
        end
        end
    end
    
    def destroy
        if current_user.projects.any?
          flash[:alert] = "あなたが管理者になっているプロジェクトが存在します。管理者を変更するか、プロジェクトを削除してください。"
          redirect_to join_project_user_path(current_user)
        else
          super
        end
  end
end
