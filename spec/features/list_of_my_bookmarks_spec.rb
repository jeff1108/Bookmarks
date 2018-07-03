require './bookmark_app.rb'

# As a user
# So that I can easily find a website I have bookmarked
# I would like to be able to see a list of my bookmarks

feature 'Bookmarks' do
  scenario 'return list of my bookmarks' do
    require 'pg'
    connection = PG.connect(dbname: 'bookmark_manager_test')
    connection.exec "INSERT INTO bookmarks (url) VALUES('http://makersacademy.com');"
    connection.exec "INSERT INTO bookmarks (url) VALUES('http://destroyallsoftware.com');"
    connection.exec "INSERT INTO bookmarks (url) VALUES('http://google.com');"
    visit('/')
    expect(page).to have_content 'http://makersacademy.com'
    expect(page).to have_content 'http://destroyallsoftware.com'
    expect(page).to have_content 'http://google.com'
  end

end
