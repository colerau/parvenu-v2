class SessionsController < ApplicationController
    def new 

    end

    def create
        # if user used omniauth
        if auth
            @user = User.find_or_create_by(uid: auth['uid']) do |u|
                u.name = auth['info']['name']
                u.email = auth['info']['email']
                u.image = auth['info']['image']
            end 
            @user.password = SecureRandom.hex
            if @user.save 
                session[:user_id] = @user.id
                flash[:notice] = "You're in."
                render 'welcome/home'
            else 
                flash[:notice] = "Something went wrong"
                redirect_to root_path
            end 
        #if user did not use omniauth
        else 
            @user = User.find_by(email: params[:email].downcase)

            if @user && @user.authenticate(params[:password])
                session[:user_id] = @user.id 
                flash[:notice] = "Log In Successful"
                redirect_to root_path
            else 
                flash[:notice] = "Could not find account :("
                render :new 
            end
        end 
    end

    def destroy 
        reset_session
        #if this doesn't work something is very wrong 
        if session[:user_id] == nil
            redirect_to '/login', notice: "You are logged out"
        end 
    end

    private 

    def auth
        request.env['omniauth.auth']
    end
end
