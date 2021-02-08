dclass SessionsController < ApplicationController

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
        
    end

end