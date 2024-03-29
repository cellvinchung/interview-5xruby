require 'rails_helper'

RSpec.feature "Missions", type: :feature do
  context "未登入" do 
    it "要求登入" do 
      visit missions_path
      expect(page).to have_content(User.human_attribute_name(:password))
    end
  end
  context "已登入" do 
    let!(:user){
      create(:user)
    }
    
    include_context 'Login'
    context "新增" do 
      before(:each) do 
        visit new_mission_path
        @current_time = Time.current
        within(".new_mission") do 
          fill_in Mission.human_attribute_name(:name), with: "正常任務"
          fill_in Mission.human_attribute_name(:start_at), with: @current_time
          fill_in Mission.human_attribute_name(:end_at), with: @current_time + 1.day
        end
      end
      scenario "成功" do 
        click_button I18n.t("submit")
        expect(page).to have_content("#{I18n.t("create")}#{I18n.t("success")}")
      end
      scenario "失敗" do 
        within(".new_mission") do 
          fill_in Mission.human_attribute_name(:name), with: nil
        end
        click_button I18n.t("submit")
        expect(page).not_to have_content("#{I18n.t("create")}#{I18n.t("success")}")
      end
    end
    context "更新" do 
      let!(:mission) {
        user.missions.create(name: "嗨你好", start_at: Time.current, end_at: Time.current+1.day, status: :pending)
      }
      before(:each) do 
        visit edit_mission_path(mission)
      end
      scenario "成功" do 
        within(".edit_mission") do 
        end
        click_button I18n.t("submit")
        expect(page).to have_content("#{I18n.t("update")}#{I18n.t("success")}")
      end
      scenario "失敗" do 
        within(".edit_mission") do 
          fill_in Mission.human_attribute_name(:name), with: nil
        end
        click_button I18n.t("submit")
        expect(page).not_to have_content("#{I18n.t("update")}#{I18n.t("success")}")
      end
    end 
    context "刪除" do 
      scenario "成功" do 
        mission = user.missions.create(name: "嗨你好", start_at: Time.current, end_at: Time.current+1.day, status: :pending)
        visit missions_path
        expect {click_link I18n.t("destroy")}.to change(Mission, :count).by(-1)
      end
    end
    context "排序" do 
      let(:params) {
        {
          name: "正常任務",
          content: "正常內容",
          start_at: "2019-10-02",
          end_at: "2019-10-31",
          priority: :high,
          status: :pending
        }
      }
      before(:each) do 
        @mission1 = user.missions.create(params)
        @mission2 = user.missions.create(params.merge(start_at: "2019-01-02",end_at: "2019-09-31"))
        @mission3 = user.missions.create(params.merge(start_at: "2019-02-02",end_at: "2019-12-31"))
      end
      scenario "建立時間" do 
        visit missions_path(q: {s: "created_at desc"})
        missions = Mission.ransack({s: "created_at desc"}).result
        expect(missions).to eq([@mission3, @mission2, @mission1])
      end
      scenario "開始時間" do 
        visit missions_path(q: {s: "start_at desc"})
        missions = Mission.ransack({s: "start_at desc"}).result
        expect(missions).to eq([@mission1, @mission3, @mission2])
      end
      scenario "結束時間" do 
        visit missions_path(q: {s: "end_at desc"})
        missions = Mission.ransack({s: "end_at desc"}).result
        expect(missions).to eq([@mission3, @mission1, @mission2])
      end
    end
    context "查詢" do 
      let(:params) {
        {
          name: "正常任務",
          content: "正常內容",
          start_at: "2019-10-02",
          end_at: "2019-10-31",
          priority: :high,
          status: :pending
        }
      }
      before(:each) do 
        @mission1 = user.missions.create(params.merge(name: "繳信用卡費", priority: :medium))
        @mission2 = user.missions.create(params.merge(name: "參加默默會", status: :working))
        @mission3 = user.missions.create(params.merge(name: "運動", status: :finished))
      end
      scenario "名稱" do 
        visit missions_path(q: {name_cont: "默默會"})
        missions = Mission.ransack({name_cont: "默默會"}).result
        
        expect(missions).to eq([@mission2])
      end
      scenario "狀態" do 
        visit missions_path(q: {status_eq: 2})
        missions = Mission.ransack({status_eq: 2}).result
        
        expect(missions).to eq([@mission3])
      end
      scenario "優先順序" do 
        visit missions_path(q: {priority_eq: 1})
        missions = Mission.ransack({priority_eq: 1}).result
        
        expect(missions).to eq([@mission1])
      end
    end
  end
end
