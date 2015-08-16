#INDEX ------------
get '/' do
  redirect '/login'
end
get '/login' do
  # render home page
 @id = session[:user_id]
  @user = User.where(id: @id).first
  erb :login
end

post '/sessions/new' do

  @user = User.find_by(email: params[:email])
    if @user == nil
      status 406
      flash[:sign_in_warning] = "WRONG E MAIL BROOOO"
      redirect to '/login'
    elsif @user.password == params[:password]
      # status 301
      session[:user_id] = @user.id
      redirect to '/cohort'
    else
      status 406
      redirect to '/login'
  end
  erb :cohort
end
get '/signup' do

erb :signup
end


post '/new/user' do

@user = User.create(
  name: params[:name],
  email: params[:email],
  password: params[:password]
)
  if @user.save
    redirect '/'
  end
erb :signup
end

#Teacher Dash ------------

get '/cohort' do
erb :cohort
end


get '/student/view' do
erb :profile
end
