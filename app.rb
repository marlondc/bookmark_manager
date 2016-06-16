ENV["RACK_ENV"] ||= "development"

require 'sinatra/base'
require_relative './app/models/data_mapper_setup'
require 'sinatra/flash'


class BookmarkManager < Sinatra::Base

	use Rack::MethodOverride
	register Sinatra::Flash

	enable :sessions
  set :session_secret, 'super secret'

  get '/' do
    redirect('/links')
  end

  get '/links' do
    erb(:index)
  end

  get '/links/new' do
  	erb(:new_link)
  end

  post '/links' do
  	link = Link.create(title: params[:title], url: params[:url])
		params[:tags].split.each do |tag|
			link.tags << Tag.create(name: tag)
		end
		link.save
  	redirect('/links')
  end

  get '/tags/:name' do
    @name = params[:name]
    tag = Tag.first(name: @name)
    @links = tag ? tag.links : []
    erb(:filtered_tags)
  end

	get '/users/new' do
		@user = User.new
		erb(:'users/new')
	end

	post '/users' do
		@user = User.create(email: params[:email], password: params[:password], password_confirmation: params[:password_confirmation])
    if @user.save
			session[:user_id] = @user.id
			redirect '/links'
		else
			flash.now[:errors] = @user.errors.full_messages
			erb(:'users/new')
		end
	end

	get '/sessions/new' do
		erb(:'sessions/new')
	end

	post '/sessions' do
		user = User.authenticate(params[:email], params[:password])
		if user
			session[:user_id] = user.id
			redirect '/links'
		else
			flash.now[:errors] = ['The email or password is incorrect']
			erb(:'sessions/new')
		end
	end

	delete '/sessions' do
		session[:user_id] = nil
		flash.keep[:notice] = 'goodbye!'
		redirect '/links'
	end

	helpers do
		def current_user
			@current_user ||= User.get(session[:user_id])
		end
	end



  # start the server if ruby file executed directly
  run! if app_file == $0
end
