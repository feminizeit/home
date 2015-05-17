require 'sinatra'

module Feminizeit
  class Application < Sinatra::Base

    configure do
      set :root, File.dirname(__FILE__)
      set :logger, $logger

      set :public_folder, 'public'

      set :raise_errors, false
      set :show_exceptions, false
    end

    not_found do
      erb :error
    end

    error 400..510 do
      erb :error
    end

    get '/' do
    end

    post '/test' do
      erb :test
    end

  end
end