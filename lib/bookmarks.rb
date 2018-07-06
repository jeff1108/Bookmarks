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
    return false unless is_url?(address)
    result = @connection.exec("INSERT INTO bookmarks (url, title) VALUES ('#{address}', '#{title}') RETURNING id, url, title")
    Bookmarks.new(result.first['id'], result.first['url'], result.first['title'])
  end

  def ==(other)
    @id = other.id
  end

  def self.delete(id)
    Bookmarks.testing
    result = @connection.exec("DELETE FROM bookmarks WHERE id = '#{id}'")
  end

  def self.update(id, url, title)
    Bookmarks.testing
    return false unless is_url?(url)
    result = @connection.exec("UPDATE bookmarks SET url = '#{url}', title = '#{title}' WHERE id = '#{id}'")
  end

  def self.find(id)
    Bookmarks.testing
    result = @connection.exec("SELECT * FROM bookmarks WHERE id = '#{id}'")
    result.map { |bookmark| Bookmarks.new(bookmark['id'], bookmark['url'], bookmark['title']) }.first 
  end

  def self.is_url?(url)
    url =~ /\A#{URI::regexp(['http', 'https'])}\z/
  end

end
