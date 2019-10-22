require 'test_helper'

class MissionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  setup do 
    @current_time = Time.current
  end
  test "可新增自己的任務" do 
  end
  test "使用者登入後，只能看見自己建立的任務" do 
  end
  test "可設定任務的開始及結束時間" do 
  end
  test "可設定任務的優先順序（高、中、低）" do 
  end
  test "可設定任務目前的狀態（待處理、進行中、已完成）" do 
  end
  test "可依狀態篩選任務" do 
  end
  test "可以任務的標題、內容進行搜尋" do 
  end
  test "可為任務加上分類標籤" do 
  end
  test "任務列表，並可依優先順序、開始時間及結束時間等進行排序" do 
  end
  test "name必填" do
    mission = Mission.new(start_at: @current_time)
    assert_not mission.valid?
  end
  test "start_at必填" do 
    mission = Mission.new(name: "asdfjlh")
    assert_not mission.valid?
  end
end
