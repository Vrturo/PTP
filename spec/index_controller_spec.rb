require_relative 'spec_helper'

describe 'index_controller' do
    before :all do
      User.destroy_all
      @user = User.new(name: "fake", email: "fake@mail.com", password_hash: "123456")
      @user.save
    end

  describe 'GET /' do
    it 'should renders a successful status' do
      get '/'
      expect(last_response.status).to eq(200)
    end

    it 'should show a users name when you sign in a user' do
      post '/sessions', {email: "fake@mail.com", password: "123456"}
      expect(last_response).to be_redirect
      follow_redirect!
      expect(last_response.body).to include("fake")
    end
  end

  describe 'GET /sessions/new' do
    it 'should render a Sign in page' do
      get '/sessions/new'
      expect(last_response.status).to eq(200)
    end
  end

  describe 'POST /sessions' do
    it 'if wrong email is entered it redirects to sign in page' do
      post '/sessions', {email: "faake@mail.com", password: '123456'}
    expect(last_response).to be_redirect
    follow_redirect!
    expect(last_request.url).to eq('http://example.org/sessions/new')
  end

    it 'if wrong password is entered it redirects to sign in page' do
      post '/sessions', {username: "fake@mail.com", password: '123'}
      expect(last_response).to be_redirect
      follow_redirect!
      expect(last_request.url).to eq('http://example.org/sessions/new')
    end

    it 'if no password is entered it redirects to sign in page' do
      post '/sessions', {email: "fake@mail.com", password: ''}

      expect(last_response).to be_redirect
      follow_redirect!
      expect(last_request.url).to eq('http://example.org/sessions/new')
    end

    it 'if logged in it should render a successful status for profile view' do
      post '/sessions', {email: "fake@mail.com", password: '123456'}
      get '/'
      expect(last_response).to be_redirect
      follow_redirect!
      expect(last_response.status).to eq(302)
    end
  end

   describe 'GET /sessions/new' do
    it 'should render a successful status for signup' do
      get '/sessions/new'
      expect(last_response.status).to eq(200)
    end
  end

  describe 'Sign up' do
    before :all do
      User.destroy_all
    end
    it 'should renders a successful status' do
      get '/users/new'
      expect(last_response.status).to eq(200)
    end

    it 'should create a new user' do
      user_data = {name: "fake", email: "fake123@mail.com", password_hash: "123456"}
      post '/users', user_data
      user = User.find_by(email: user_data[:email])
      expect(user.name).to eq(user_data[:name])
    end
  end
end
