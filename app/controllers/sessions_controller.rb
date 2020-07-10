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

    end
end
