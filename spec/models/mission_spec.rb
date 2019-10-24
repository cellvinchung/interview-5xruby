require 'rails_helper'

RSpec.describe Mission, type: :model do
  let(:mission) {
    build(:mission)
  }
  context "validation驗證" do 
    it "name必填" do
      mission.name = nil
      expect(mission.save).to eq(false)
    end
    it "start_at必填" do 
      mission.start_at = nil
      expect(mission.save).to eq(false)
    end
    it "end_at必填" do 
      mission.end_at = nil
      expect(mission.save).to eq(false)
    end
    it "end_at要晚於start_at" do 
      mission.start_at = "2019-10-31"
      mission.end_at = "2019-10-01"
      expect(mission.save).to eq(false)
    end
    it "正常" do 
      expect(mission.save).to eq(true)
    end
  end

  context "狀態" do 
    it "待處理變進行中" do 
      mission.save
      expect(mission.may_start?).to eq(true)
    end
    it "待處理變完成" do 
      mission.save
      expect(mission.may_finish?).to eq(true)
    end
    it "進行中變完成" do 
      mission.start
      mission.save
      expect(mission.may_finish?).to eq(true)
    end
    it "完成不可變進行中" do 
      mission.finish
      mission.save
      expect(mission.may_start?).to eq(false)
    end
  end
end
