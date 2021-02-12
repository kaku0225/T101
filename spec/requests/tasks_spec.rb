require 'rails_helper'

RSpec.describe "Tasks", type: :request do
  let(:task_qq) { Task.create(name: 'aa', content: 'bb')}
  it "#index" do
    get "/tasks"
    expect(response).to have_http_status(200)
    expect(response).to render_template(:index)
    expect(response.body).to include('aa')
    expect(response.body).not_to include('zz')
  end

  it "#show" do
    get "/tasks/#{task_qq.id}"
    expect(response).to have_http_status(200)
    expect(response).to render_template(:show)
    expect(response.body).to include('aa')
  end

  it "#create" do
    params = { task: {name: 'name', content: 'content'}}
    post "/tasks", params: params #後面那是自己取的，如果把上面那個的params改成bbb下面也可以改成 params: bbb
    expect(response).to have_http_status(302)
    expect(Task.last.name).to eq(params[:task][:name])
  end
end
