require 'bookmarks'

describe Bookmarks do
  describe '.all' do
    it 'show all bookmarks' do
      require 'pg'
      connection = PG.connect(dbname: 'bookmark_manager_test')
      connection.exec "INSERT INTO bookmarks (url) VALUES('http://makersacademy.com');"
      connection.exec "INSERT INTO bookmarks (url) VALUES('http://destroyallsoftware.com');"
      connection.exec "INSERT INTO bookmarks (url) VALUES('http://google.com');"
      bookmarks = Bookmarks.all
      expect(bookmarks).to include("http://makersacademy.com")
      expect(bookmarks).to include("http://destroyallsoftware.com")
      expect(bookmarks).to include("http://google.com")
    end
  end
end
