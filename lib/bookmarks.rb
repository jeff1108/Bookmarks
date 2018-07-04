require 'pg'
class Bookmarks

  def self.all
    Bookmarks.testing
    # connection = PG.connect(dbname: 'bookmark_manager')
    result = @connection.exec("SELECT * FROM bookmarks")
    result.map { |bookmark| bookmark['url'] }
  end

  def self.testing
    if ENV['ENVIRONMENT'] == 'test'
      @connection = PG.connect(dbname: 'bookmark_manager_test')
    else
      @connection = PG.connect(dbname: 'bookmark_manager')
    end
  end

  def self.create(address)
    Bookmarks.testing
    @connection.exec("INSERT INTO bookmarks (url) VALUES ('#{address[:url]}')")
  end
  #
  # def self.real?(url)
  #   url =~ /\A#{URI::regexp(['http', 'https'])}\z/
  # end


end
