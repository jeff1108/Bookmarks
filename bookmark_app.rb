require 'sinatra/base'
require 'sinatra/flash'
require './lib/bookmarks'
require 'uri'

class BookmarkWeb < Sinatra::Base
  enable :sessions
  register Sinatra::Flash

  get '/' do
    erb :index
  end

  get '/bookmarks' do
    @bookmarks = Bookmarks.all
    erb :bookmarks
  end

  get '/bookmarks/new' do
    erb :new
  end

  post '/save' do
    if params['url'] =~ /\A#{URI::regexp(['http', 'https'])}\z/
      Bookmarks.create(url: params['url'])
      redirect '/'
    else
      flash[:notice] = 'You must submit a valid url'
      redirect '/bookmarks/new'
    end
  end



  run! if app_file == $0
end
