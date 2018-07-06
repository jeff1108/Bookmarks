require './bookmark_app.rb'

# As a user
# So that I can remember a website I like
# I would like to be able to add a new bookmark

feature 'create' do
  scenario 'should save a new bookmark' do
    visit('/')
    click_button('Create Bookmark')
    fill_in 'url', with: 'http://google.com'
    fill_in 'title', with: 'Google'
    click_button('Save')
    click_button('View Bookmarks')
    expect(page).to have_content('Google')
  end
end

feature 'error' do
  scenario 'is not a real url' do
    visit('/')
    click_button('Create Bookmark')
    fill_in 'url', with: 'ht://google.com'
    fill_in 'title', with: 'wrong url'
    click_button('Save')
    # expect(page).not_to have_content('not a real url')
    expect(page).to have_content "You must submit a valid url"
    end
end
