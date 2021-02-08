class ApplicationController < ActionController::Base
    
    helper_method :current_user, :logged_in?

    def login!(user)
        session[:session_token] = user.reset_session_token!
    end

    def current_user
        @current_user ||= User.find_by(session_token: session[:session_token])
    end

    def logout!
        current_user.try(:reset_session_token!)
        session[:session_token] = nil
        current_user = nil
    end

    def logged_in?
       !!current_user
    end

    def require_logged_out
        redirect_to cats_url if logged_in?
    end

    def require_logged_in
        redirect_to new_session_url unless logged_in?
    end


    def confirm_owner
        current_user.cats.each do |cat|
        return if cat.id == params[:id].to_i
        end
        redirect_to cats_url
    end

end
