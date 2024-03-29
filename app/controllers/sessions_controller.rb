class SessionsController < ApplicationController
    def new
        
    end
    def create
        @user = User.find_by(email: params[:user][:email])
        if @user && @user.authenticate(params[:user][:password]) 
            session[:user_id] = @user.id
            flash[:success] = "#{t("login")}#{t("success")}"
            redirect_to root_path
        else
            flash[:alert] = "#{t("login")}#{t("fail")}"
            render :new
        end
    end
    def destroy
        session.delete(:user_id)
        flash[:success] = "#{t("logout")}#{t("success")}"
        redirect_to login_path
    end
end
