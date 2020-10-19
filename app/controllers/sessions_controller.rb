class SessionsController < ApplicationController

    def new
    end

    def create
        user = User.find_by(email: params[:session][:email].downcase)
        if user && user.authenticate(params[:session][:password])
          session[:user_id] = user.id
          json_response "Signed In Successfully", true, {user: user}, :ok
          #flash[:notice] = "Logged in successfully"
          #redirect_to user
        else
          #json_response "Unauthorized", false, {}, :unauthorized
          flash.now[:alert] = "There was something wrong with your login details"
          render 'new'
        end
    end

    def destroy
      #user.generate_new_authentication_token
      #json_response "Log out Successfully", true, {}, :ok
         session[:user_id] = nil
         flash[:notice] = "Logged out"
         redirect_to root_path
    end
end