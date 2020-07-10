class SessionsController < ApplicationController
    def new 

    end

    def create
        user = User.find_by(email: params[:email].downcase)

        if user && user.authenticate(params[:password])
            session[:user_id] = user.id 
            flash[:notice] = "Log In Successful"
            redirect_to root_path
        else 
            flash[:notice] = "Could not find account :("
            render :new 
        end
    end

    def destroy 
        reset_session
        #if this doesn't work something is very wrong 
        if session[:user_id] == nil
            redirect_to '/login', notice: "You are logged out"
        end 
    end
end
