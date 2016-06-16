ENV['RACK_ENV'] ||= 'development'
# APP_ROOT = File.expand_path File.join(__dir__, "..")
# RACK_ENV = ENV['RACK_ENV']
# Bundler.require(:default, RACK_ENV)

require 'sinatra/base'
require 'sinatra/flash'
require 'sinatra/partial'

require_relative 'data_mapper_setup'

require_relative 'server'
require_relative 'controller/links'
require_relative 'controller/tags'
require_relative 'controller/sessions'
require_relative 'controller/users'


class BookmarkManager < Sinatra::Base

  use Rack::MethodOverride
  register Sinatra::Flash
  enable :sessions
  set :session_secret, "super secret"


  helpers do
    def current_user
      @current_user ||=User.get(session[:user_id])
    end
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
