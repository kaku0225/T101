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
end
