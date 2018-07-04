require 'bookmarks'

describe Bookmarks do
  describe '.all' do
    it 'show all bookmarks' do
      # require 'pg'
      # connection = PG.connect(dbname: 'bookmark_manager_test')
      # connection.exec "INSERT INTO bookmarks (url) VALUES('http://makersacademy.com');"
      # connection.exec "INSERT INTO bookmarks (url) VALUES('http://destroyallsoftware.com');"
      # connection.exec "INSERT INTO bookmarks (url) VALUES('http://google.com');"
      Bookmarks.create(url: 'http://makersacademy.com')
      Bookmarks.create(url: 'http://destroyallsoftware.com')
      Bookmarks.create(url: 'http://google.com')
      bookmarks = Bookmarks.all
      expect(bookmarks).to include('http://makersacademy.com')
      expect(bookmarks).to include('http://destroyallsoftware.com')
      expect(bookmarks).to include('http://google.com')
    end
  end

  describe '.create' do
    it 'create a new bookmark' do
      Bookmarks.create(url: 'http://facebook.com')
      expect(Bookmarks.all).to include('http://facebook.com')
    end

    # it 'does not save a new bookmark if url is not valid' do
    #   Bookmarks.create('htt://google.con')
    #   expect(Bookmarks.all).not_to include('htt://google.con')
    # end
  end
end
