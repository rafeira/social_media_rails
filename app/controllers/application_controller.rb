class ApplicationController < ActionController::Base
    before_action :authenticate_user!
    before_action :set_locale

    def set_locale
        if params[:locale]
            cookies[:locale] = params[:locale]
        end
        if cookies[:locale]
            if I18n.locale != cookies
                I18n.locale = cookies[:locale]
            end
        end
    end
end
