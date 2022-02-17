require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /users' do
    before(:example) { get users_path }
    it 'should work!' do
      expect(response).to have_http_status(200)
    end
    it 'renders template correctly' do
      expect(response).to render_template(:index)
    end
    it "doesn\'t renders show template  other than /users" do
      expect(response).to_not render_template(:show)
    end
    it 'shows the correct placeholder text in index' do
      expect(response.body).to include('<p>Find me in app/views/users/index.html.erb</p>')
    end
  end
  describe 'GET /users/:id' do
    before(:example) { get '/users/1' }
    it 'should work!' do
      expect(response).to have_http_status(200)
    end
    it 'shows the correct placeholder text in show' do
      expect(response.body).to include('<p>Find me in app/views/users/show.html.erb</p>')
    end
    it 'renders show template correctly' do
      expect(response).to render_template(:show)
    end
    it "doesn\'t renders index template  other than /users#show" do
      expect(response).to_not render_template(:index)
    end
  end
end
