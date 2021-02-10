require 'rails_helper'

RSpec.describe Task, type: :model do
  it "可存取" do
    task = Task.create!(name: 'aa', content: 'bb')
    expect(task).to eq(Task.last)
  end

  it "欄位數量名稱正確" do
    columns = Task.column_names
    expect(columns).to include("id")
    expect(columns).to include("name")
    expect(columns).to include("content")
    expect(columns).not_to include("aa")
  end
end
