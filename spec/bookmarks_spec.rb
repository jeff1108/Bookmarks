require 'bookmarks'

describe Bookmarks do
  describe '.all' do
    it 'show all bookmarks' do
      # require 'pg'
      # connection = PG.connect(dbname: 'bookmark_manager_test')
      # connection.exec "INSERT INTO bookmarks (url) VALUES('http://makersacademy.com');"
      # connection.exec "INSERT INTO bookmarks (url) VALUES('http://destroyallsoftware.com');"
      # connection.exec "INSERT INTO bookmarks (url) VALUES('http://google.com');"
      # Bookmarks.create(url: 'http://makersacademy.com')
      # Bookmarks.create(url: 'http://destroyallsoftware.com')
      # Bookmarks.create(url: 'http://google.com')
      bookmark_1 = Bookmarks.create('http://makersacademy.com', 'Maker')
      bookmark_2 = Bookmarks.create('http://destroyallsoftware.com', 'Destroy')
      bookmark_3 = Bookmarks.create('http://google.com', 'Google')
      bookmarks = Bookmarks.all
      # expect(bookmarks).to include('http://makersacademy.com')
      # expect(bookmarks).to include('http://destroyallsoftware.com')
      # expect(bookmarks).to include('http://google.com')
      expected_bookmarks = [
        bookmark_1,
        bookmark_2,
        bookmark_3,
      ]
    end
  end

  describe '.create' do
    it 'create a new bookmark' do
      # Bookmarks.create(url: 'http://facebook.com')
      bookmark =  Bookmarks.create('http://facebook.com', 'Facebook')
      # expect(Bookmarks.all).to include('http://facebook.com')
      expect(Bookmarks.all).to include bookmark
    end
  end

    # it 'does not save a new bookmark if url is not valid' do
    #   Bookmarks.create('htt://google.con')
    #   expect(Bookmarks.all).not_to include('htt://google.con')
    # end

    describe '#==' do
      it 'two bookmarks are equal if their ids match' do
        bookmark_1 = Bookmarks.new(1, 'http://testbookmark.com', 'Test')
        bookmark_2 = Bookmarks.new(1, 'http://testbookmark.com', 'Test')
        expect(bookmark_1).to eq (bookmark_2)
      end
    end

    describe '.delete' do
      it 'deletes a bookmark' do
        Bookmarks.create('http://makersacademy.com', "Maker")
        Bookmarks.delete(1)
        bookmarks = Bookmarks.all
        urls = bookmarks.map(&:url)
        expect(urls).not_to include "http://www.makersacademy.com"
      end
    end

    describe '.update' do
      it 'update a bookmark' do
        bookmark = Bookmarks.create('http://google.com', "Google")
        Bookmarks.update(bookmark.id, 'http://www.snakersacademy.com', "Snakers Academy")
        bookmarks = Bookmarks.all
        # expect(bookmarks).to include 'Snakers Academy'
        # expect(bookmarks).to include 'http://www.snakersacademy.com'
        # expect(bookmarks).not_to include 'Google'
        # expect(bookmarks).not_to include 'http://google.com'
        urls = bookmarks.map(&:url)
        titles = bookmarks.map(&:title)

        expect(urls).not_to include "http://google.com"
        expect(titles).not_to include "Google"
        expect(urls).to include "http://www.snakersacademy.com"
        expect(titles).to include "Snakers Academy"
      end
    end

    describe '.find' do
      it "find the bookmark" do
        bookmark = Bookmarks.create('http://www.makersacademy.com', "Maker")
        bookmark = Bookmarks.find(bookmark.id)
        expect(bookmark.url).to eq 'http://www.makersacademy.com'
        expect(bookmark.title).to eq 'Maker'
      end
    end
end
