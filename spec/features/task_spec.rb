require 'rails_helper'

RSpec.feature "Tasks", type: :feature do
  let!(:task_1) { Task.create(name: Faker::Lorem.sentence, content: Faker::Lorem.sentence)}


  scenario "click new" do
    visit root_path
    expect(page).to have_content(task_1[:name])
    expect(page).to have_content(task_1[:content])
    expect(page).not_to have_content("baba")
    click_link "新增任務"
    expect(find('.task-new').text).to eq('Task New')
  end

  scenario "create a new task" do
    visit new_task_path
    fill_in "任務", with: "aaa"
    fill_in "內容", with: "測試a"
    
    expect{click_button "新增任務"}.to change{Task.all.size}.by(1)
    expect(page).to have_content "新增成功"
    expect(page).to have_content "aaa"
    expect(page).to have_content "測試a"
  end

  scenario "create a new task on false" do
    visit new_task_path
    fill_in "任務", with: "aaa"
    fill_in "內容", with: ""
    
    expect{click_button "新增任務"}.to change{Task.all.size}.by(0)
    expect(page).to have_content "任務內容不可空白"
  end

  scenario "view task in index" do
    visit root_path
    
    expect(page).to have_content(task_1[:name])
    expect(page).to have_content(task_1[:content])
  end

  scenario "click edit" do
    visit root_path
    click_link "編輯"
    expect(find('.task-edit').text).to eq('Task Edit')
  end

  scenario "update a  task" do
    visit edit_task_path
    fill_in "任務", with: "aaa"
    fill_in "內容", with: "測試a"
    
    expect{click_button "新增任務"}.to change{Task.all.size}.by(1)
    expect(page).to have_content "新增成功"
    expect(page).to have_content "aaa"
    expect(page).to have_content "測試a"
  end
end
