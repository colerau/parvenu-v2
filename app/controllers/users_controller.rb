class UsersController < ApplicationController
    def new 
        @user = User.new
    end

    def create 
        @user = User.new(user_params)

        @user.email.downcase!

        if @user.save
            flash[:notice] = "You're in."
            redirect_to root_path
        else 
            flash[:notice] = "Couldn't create account :("
            render :new 
        end
    end

    private 

    def user_params 
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end