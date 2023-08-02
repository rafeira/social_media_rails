module Users
  module Profile
    class UpdateDataController < ::ApplicationController
      skip_before_action :verify_user_data, only: [:add_name]
      before_action :set_user
      def add_name
      end
      def update
        if @user.update(users_params)
          redirect_to root_path
        else
          redirect_to users_profile_add_name_path
        end
      end
      private
      def set_user
        @user = current_user
      end
      def users_params
        params.require(:user).permit(:first_name, :last_name)
      end
    end
  end
end
