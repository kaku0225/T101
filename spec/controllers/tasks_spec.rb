require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  # before(:all) do
  #   puts "before all"

  #   @task_1 = Task.create(name: 'aa', content: 'bb')
  #   @task_2 = Task.create(name: 'cc', content: 'cc')
  # end


  # before(:each) do
  #   puts "before each"
  #   login_user
  #   api_job

  #   @task_1 = Task.create(name: 'aa', content: 'bb')
  #   @task_2 = Task.create(name: 'cc', content: 'cc')
  # end

  let(:task_qq) { Task.create(name: 'aa', content: 'bb')}

  # before do
  #   @task_1 = Task.create(name: 'aa', content: 'bb')
  #   @task_2 = Task.create(name: 'cc', content: 'cc')
  # end



  it '#index' do
    get :index
    expect(response).to have_http_status(200)
    expect(response).to render_template(:index)
  end

  it '#new' do
    get :new
    expect(response).to have_http_status(200)
    expect(response).to render_template(:new)
  end

  describe "#create" do
    before(:all) do
      @params_task = { task: {name: 'name', content: 'content'}}
    end
    it "新增一筆資料" do
      expect { post :create, params: @params_task }.to change{Task.all.size}.by(1)
    end

    it 'redirect on success' do
      post :create, params: @params_task
      expect(response).to have_http_status(302)
      expect(response).not_to have_http_status(200)
      expect(response).to redirect_to(root_path)
    end
  end

  it '#edit' do
    get :edit, params: {id: task_qq[:id]}
    expect(response).to have_http_status(200)
    expect(response).to render_template(:edit)
  end

  describe "#update" do
    # before(:all) do
    #   @params_task = { id: task_qq.id, task: { name: 'name', content: 'content'}}
    # end

    let(:params_task) do 
      {id: task_qq.id, task: { name: 'name', content: 'content'}}
    end

    it "更改一筆資料" do
      post :update, params: params_task
      expect(Task.find(task_qq.id).name).to eq("name")
    end

    it 'redirect on success' do
      post :update, params: params_task
      expect(response).to have_http_status(302)
      expect(response).not_to have_http_status(200)
      expect(response).to redirect_to(root_path)
    end
  end
end
