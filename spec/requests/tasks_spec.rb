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

  it "#new" do
    get "/tasks/new"
    expect(response).to have_http_status(200)
    expect(response).to render_template(:new)
    expect(response.body).to include('name')
    expect(response.body).not_to include('zz')
  end

  it "#create" do
    params = { task: {name: 'name', content: 'content'}}
    params1 = { task: {name: 'name1', content:''}}

    post "/tasks", params: params #後面那是自己取的，如果把上面那個的params改成bbb下面也可以改成 params: bbb
    expect(response).to have_http_status(302)
    expect(Task.last.name).to eq(params[:task][:name])

    post "/tasks", params: params1
    expect(response).not_to have_http_status(302)
    expect(response).to have_http_status(200)
    expect(response).to render_template(:new)
  end

  it "#edit" do
    get "/tasks/#{task_qq.id}/edit"
    expect(response).to have_http_status(200)
    expect(response).to render_template(:edit)
    expect(response.body).to include('name')
    expect(response.body).not_to include('zz')
  end

  it "#update" do
    params = { task: {name: 'name', content: 'content'}} 
    params1 = { task: {name: 'name1', content:''}}

    put "/tasks/#{task_qq.id}", params: params
    expect(response).to have_http_status(302)
    expect(task_qq.reload.name).to eq(params[:task][:name])

    put "/tasks/#{task_qq.id}", params: params1
    expect(response).not_to have_http_status(302)
    expect(response).to have_http_status(200)
    expect(response).to render_template(:edit)
  end

  it "#destroy" do
    expect { delete "/tasks/#{task_qq.id}" }.to change{Task.all.size}.by(0)
    expect(response).to have_http_status(302)
  end
end
