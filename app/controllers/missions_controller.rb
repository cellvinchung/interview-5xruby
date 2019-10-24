class MissionsController < ApplicationController
    before_action :set_mission, except: [:index, :new, :create]
    def index
        @q = Mission.ransack(params[:q])
        @missions = @q.result
        @missions = @missions.page(params[:page])
    end
    def show
        
    end
    def new
        @mission = Mission.new
    end
    def create
        @mission = Mission.new(permit_params)
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
        @mission = Mission.find(params[:id])
    end
end
