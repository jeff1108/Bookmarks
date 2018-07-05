require 'pg'
class Bookmarks
  attr_reader :id, :url, :title
  def initialize(id, url, title)
    @id = id
    @url = url
    @title = title
  end

  def self.all
    Bookmarks.testing
    # connection = PG.connect(dbname: 'bookmark_manager')
    result = @connection.exec("SELECT * FROM bookmarks")
    result.map { |bookmark| Bookmarks.new(bookmark['id'], bookmark['url'], bookmark['title']) }
  end

  def self.testing
    if ENV['ENVIRONMENT'] == 'test'
      @connection = PG.connect(dbname: 'bookmark_manager_test')
    else
      @connection = PG.connect(dbname: 'bookmark_manager')
    end
  end

  def self.create(address, title)
    Bookmarks.testing
    result = @connection.exec("INSERT INTO bookmarks (url, title) VALUES ('#{address}', '#{title}') RETURNING id, url, title")
    Bookmarks.new(result.first['id'], result.first['url'], result.first['title'])
  end

  def ==(other)
    @id = other.id
  end


end
