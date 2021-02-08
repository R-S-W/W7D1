class SessionsController < ApplicationController
    before_action :require_logged_out, only: [:new, :create]
    before_action :require_logged_in, only: [:destroy]
    
    def new
        @user = User.new
        render :new
    end

    def create
        @user = User.find_by_credentials(
            params[:user][:user_name],
            params[:user][:password]
        )

        if @user.nil?
            render json: "Credentials were wrong", status: :unprocessable_entity
        else
            login!(@user)
            redirect_to cats_url
        end    
    end

    def destroy
        logout!
        redirect_to new_session_url
    end

end