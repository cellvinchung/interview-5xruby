class Admin::UsersController < MissionsController
    before_action :authenticate_admin!
    before_action :set_user, except: [:index]
    def index
        @users = User.page(params[:page])
    end
    def show
        @q = @user.missions.ransack(params[:q])
        @missions = @q.result.page(params[:page])
    end
    def new
    end
    def create
        @user = User.new(permit_params)
        if @user.save
            flash[:notice] = "#{t("create")}#{t("success")}"
            redirect_to admin_user_path(@user)
        else
            render "new"
        end
    end
    def edit
        
    end
    def update
        if @user.update(permit_params)
            flash[:notice] = "#{t("update")}#{t("success")}"
            redirect_to admin_user_path(@user)
        else
            render "edit"
        end
    end
    def destroy
        if @user.destroy
            flash[:notice] = "#{t("destroy")}#{t("success")}"
        else
            flash[:error] = "#{t("at_least_one_admin")}"
        end
            redirect_to admin_users_path
    end
    private
    def permit_params
        params.require(:user).permit(
            :email,
            :name,
            :password,
            :password_confirmation,
            :role
        )
    end
    def set_user
        @user = User.find_by(id: params[:id]) || User.new
    end
    def authenticate_admin!
        redirect_to missions_path, alert: t("require_admin") if !current_user.admin?
    end
end
