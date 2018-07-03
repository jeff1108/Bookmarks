require 'sinatra/base'
require './lib/bookmarks'

class BookmarkWeb < Sinatra::Base

  get '/' do
    @bookmarks = Bookmarks.all
    erb :index
  end


  run! if app_file == $0
end
