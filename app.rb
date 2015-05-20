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
      erb :home
    end

    get '/search' do
      erb :search
    end

    get '/about' do 
      erb :about
    end

    # get '/about' do
    #   erb :about
    # end

    get '/google/normal' do
      require 'net/http'
      html = Net::HTTP.get(URI google_shop_url(params[:q]))
      google_shop_cleaner(html)
    end

    get '/google/feminizeit' do
      require 'net/http'
      html = Net::HTTP.get(URI google_shop_url(params[:q] + '%20women'))
      html = hide_the_moneymaker_technology(html)
      google_shop_cleaner(html)
    end

    def hide_the_moneymaker_technology(html)
      html = html.gsub(/value="(.+?)women/, 'value="\\1')
      html = html.gsub(/<b>(wome.+?)<\/b>/i, '')
      html.gsub(/<b>(woma.+?)<\/b>/i, '')
    end

    def google_shop_url(query)
      query = query.gsub(' ', '+')
      "https://www.google.com/search?output=search&tbm=shop&q=#{query}&oq=#{query}&gs_l=products-cc.3..0l10.27221.28020.0.28134.6.5.1.0.0.0.316.537.4j3-1.5.0.msedr...0...1ac.1.64.products-cc..0.6.540.d3WzbVwsYws&gws_rd=ssl#tbm=shop&q=#{query}"
    end

    def google_shop_cleaner(html)
      html = html.gsub('/images/', 'http://google.com/images/')
      html = html.gsub('/xjs/', 'http://google.com/xjs/')
      html = html.gsub(/\<div id=gbar.+?\<\/div\>/m, '')
      html = html.gsub(/\<div id="_FQd".+?\<\/div\>/m, '')
      html.gsub(/\<div id=guse.+?\<\/div\>/m, '')
    end

  end
end