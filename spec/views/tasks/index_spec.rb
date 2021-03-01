require 'rails_helper'

RSpec.describe 'tasks/index.html.erb', type: :view do
  let(:task_qq) { Task.create(name: 'aa', content: 'bb', endtime:"2021-03-25 14:24:00.000000000 +0800", priority:"low")}
  before do
    @task_1 = Task.create!(name:'aa', content:'bb', endtime:"2021-03-25 14:24:00.000000000 +0800", priority:"low")
    @task_2 = Task.create!(name:'cc', content:'dd', endtime:"2021-03-25 14:24:00.000000000 +0800", priority:"low")
  end
  xit 'can render' do
    @tasks = Task.all
    render
    expect(rendered).to include('任務')
    expect(rendered).to include('aa')
    expect(rendered).not_to include('zz')
    expect(rendered).to include('編輯')
    expect(rendered).to include('刪除')
  end
end