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

  it '欄位必填' do
    expect(Task.new).not_to be_valid
    expect(Task.new(name:'bb', content:'cc')).to be_valid
  end

  
  it "is valid with a first name, last name, email, and password" do
    task = Task.new(
      name: "zzz",
      content:  "abc",
      )
      expect(task).to be_valid 
    end
    
  it "is invalid without a first name" do
      task = Task.new(name: nil)
      task.valid?
      expect(task.errors[:name]).to include("任務名稱不可空白！")
  end
    
end
