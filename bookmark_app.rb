require 'sinatra/base'
require 'sinatra/flash'
require './lib/bookmarks'
require 'uri'

class BookmarkWeb < Sinatra::Base
  enable :sessions
  register Sinatra::Flash
  set :method_override, true

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

  post '/bookmarks' do
    if Bookmarks.create(params['url'], params['title'])
      redirect '/'
    else
      flash[:notice] = 'You must submit a valid url'
      redirect '/bookmarks/new'
    end
  end

  delete '/bookmarks/:id' do
    Bookmarks.delete(params['id'])
    # connection = PG.connect(dbname: 'bookmark_manager_test')
    # connection.exec("DELETE FROM bookmarks WHERE id = #{param['id']} RETURNING id")
    redirect '/bookmarks'
  end

  get '/bookmarks/:id/edit' do
    # @bookmark_id = params['id']
    @bookmark = Bookmarks.find(params['id'])
    erb :edit
  end

  patch '/bookmarks/:id' do
    if Bookmarks.update(params['id'], params['url'], params['title'])
      redirect '/bookmarks'
    else
      flash[:notice] = 'You must submit a valid url'
      redirect '/bookmarks/:id/edit'
    end
  end



  run! if app_file == $0
end
