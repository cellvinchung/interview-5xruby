class MissionsController < ApplicationController
    before_action :set_mission, except: [:index, :new, :create]
    def index
        @missions = Mission.all
    end
    def show
        
    end
    def new
        @mission = Mission.new
    end
    def create
        @mission = Mission.create(permit_params)
        flash[:notice] = "建立成功"
        redirect_to mission_path(@mission)
    end
    def edit
        
    end
    def update
        @mission.update(permit_params)
        flash[:notice] = "更新成功"
        redirect_to mission_path(@mission)
    end
    def destroy
        @mission.destroy
        flash[:notice] = "刪除成功"
        redirect_to missions_path
    end
    private
    def permit_params
        params.require(:mission).permit(
            :name,
            :content
        )
    end
    def set_mission
        @mission = Mission.find(params[:id])
    end
end
