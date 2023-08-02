class ApplicationController < ActionController::Base
	before_action :authenticate_user!
	before_action :set_locale
	before_action :verify_user_data

	def set_locale
		cookies[:locale] = params[:locale] if params[:locale]
		I18n.locale = cookies[:locale] if I18n.locale != cookies[:locale]
	end

	def verify_user_data
		redirect_to users_profile_add_name_path if current_user.pending_data?
	end
end
