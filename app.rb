ENV["RACK_ENV"] ||= "development"

require 'sinatra/base'
require_relative './app/models/data_mapper_setup'


class BookmarkManager < Sinatra::Base

	enable :sessions

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
  	link = Link.new(title: params[:title], url: params[:url])
    tag = Tag.first_or_create(name: params[:tags])
    link.tags << tag
    link.save
  	redirect('/links')
  end

  get '/tags/:name' do
    @name = params[:name]
    tag = Tag.first(name: @name)
    @links = tag ? tag.links : []
    erb(:filtered_tags)
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
