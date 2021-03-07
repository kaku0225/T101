require 'rails_helper'

RSpec.feature "Tasks", type: :feature do
  let!(:task_1) { Task.create(name: Faker::Lorem.sentence, content: Faker::Lorem.sentence, endtime:"2021-03-25 14:24:00.000000000 +0800", priority:"low")}


  scenario "click new" do
    visit users_tasks_path
    expect(page).to have_content(task_1[:name])
    expect(page).to have_content(task_1[:content])
    expect(page).not_to have_content("baba")
    click_link "新增任務"
    expect(find('.task-new').text).to eq('Task New')
  end

  scenario "create a new task" do
    visit new_users_task_path
    fill_in "任務", with: "aaa"
    fill_in "內容", with: "測試a"
    fill_in "任務結束時間", with: "2021-03-25 14:24:00.000000000 +0800"
    expect{click_button "新增任務"}.to change{Task.all.size}.by(1)
    expect(page).to have_content "新增成功"
    expect(page).to have_content "aaa"
    expect(page).to have_content "測試a"
  end
  

  scenario "create a new task on false" do
    visit new_users_task_path
    fill_in "任務", with: "aaa"
    fill_in "內容", with: ""
    fill_in "任務結束時間", with: "2021-03-25 14:24:00.000000000 +0800"
    
    expect{click_button "新增任務"}.to change{Task.all.size}.by(0)
    expect(page).to have_content "不可空白"
  end

  scenario "view task in index" do
    visit users_tasks_path
    
    expect(page).to have_content(task_1[:name])
    expect(page).to have_content(task_1[:content])
  end

  scenario "click edit" do
    visit edit_users_task_path(task_1)
    click_link "編輯"
    expect(find('.task-edit').text).to eq('Task Edit')
  end

  scenario "update a task" do
    visit edit_users_task_path(task_1)
    fill_in "任務", with: "aaaa"
    fill_in "內容", with: "測試aa"
    
    click_button "編輯任務"
    expect(page).to have_content "aaaa"
    expect(page).to have_content "測試aa"
  end

  scenario "click 刪除" do
    visit users_tasks_path
    expect{click_link "刪除"}.to change{Task.all.size}.by(-1)
  end

  xdescribe "狀態更新" do
    scenario "click 狀態更新_progerss" do
      visit users_tasks_path
      click_link "更新狀態"
      expect{task_1.state}.to equal "progress"
    end
  
    scenario "click 狀態更新_complete" do
      visit users_tasks_path
      click_link "更新狀態"
      expect{task_1.state}.to equal "complete"
    end
  end

  xscenario "搜尋測試" do
    visit users_tasks_path
    fill_in "State 包含", with: "pending"
    expect(page).to have_content "pending"
    expect(page).not_to have_content "progress"
    expect(page).not_to have_content "complete"
  end
end
