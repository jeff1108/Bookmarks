require './bookmark_app.rb'

# As a user
# So that I can easily find a website I have bookmarked
# I would like to be able to see a list of my bookmarks

feature 'Bookmarks' do
  scenario 'return list of my bookmarks' do
    # require 'pg'
    # connection = PG.connect(dbname: 'bookmark_manager_test')
    # connection.exec "INSERT INTO bookmarks (url) VALUES('http://makersacademy.com');"
    # connection.exec "INSERT INTO bookmarks (url) VALUES('http://destroyallsoftware.com');"
    # connection.exec "INSERT INTO bookmarks (url) VALUES('http://google.com');"
    Bookmarks.create('http://makersacademy.com', 'Maker')
    Bookmarks.create('http://destroyallsoftware.com', 'Destroy')
    Bookmarks.create('http://google.com', 'Google')
    visit('/')
    click_button("View Bookmarks")
    expect(page).to have_content 'Maker'
    expect(page).to have_content 'Destroy'
    expect(page).to have_content 'Google'
  end

end
