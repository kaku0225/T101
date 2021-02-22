require 'rails_helper'

RSpec.feature "Tasks", type: :feature do
  let!(:task_1) { Task.create(name: Faker::Lorem.sentence, content: Faker::Lorem.sentence)}

  scenario "create a new task" do
    visit new_task_path
    fill_in "任務", with: "aaa"
    fill_in "內容", with: "測試a"
    
    expect{click_button "新增任務"}.to change{Task.all.size}.by(1)
    expect(page).to have_content "新增成功"
    expect(page).to have_content "aaa"
    expect(page).to have_content "測試a"
  end

  scenario "create a new task" do
    visit new_task_path
    fill_in "任務", with: "aaa"
    fill_in "內容", with: ""
    
    expect{click_button "新增任務"}.to change{Task.all.size}.by(0)
    expect(page).to have_content "任務內容不可空白"
  end
end
