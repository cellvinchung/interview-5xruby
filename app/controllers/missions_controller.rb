class MissionsController < ApplicationController
    before_action :set_mission, except: [:index]
    before_action :authenticate_user!

    def index
        @q = current_user.missions.ransack(params[:q])
        @missions = @q.result
        @missions = @missions.page(params[:page])
    end
    def show
    end
    def new
    end
    def create
        @mission = current_user.missions.new(permit_params)
        if @mission.save
            flash[:notice] = "#{t("create")}#{t("success")}"
            redirect_to mission_path(@mission)
        else
            render "new"
        end
    end
    def edit
        
    end
    def update
        if @mission.update(permit_params)
            flash[:notice] = "#{t("update")}#{t("success")}"
            redirect_to mission_path(@mission)
        else
            render "edit"
        end
    end
    def destroy
        @mission.destroy
        flash[:notice] = "#{t("destroy")}#{t("success")}"
        redirect_to missions_path
    end

    private
    def permit_params
        params.require(:mission).permit(
            :name,
            :content,
            :start_at,
            :end_at,
            :status,
            :priority
        )
    end
    def set_mission
        @mission = current_user.missions.find_by(id: params[:id]) || current_user.missions.new
    end
    def authenticate_user!
        redirect_to login_path, alert: t("please_log_in") if !user_signed_in?
    end
end
