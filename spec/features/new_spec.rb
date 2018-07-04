require './bookmark_app.rb'

feature 'create' do
  scenario 'save a new bookmark' do
    visit('/')
    click_button('Create Bookmark')
    fill_in 'url', with: 'http://google.com'
    click_button('Save')
    click_button('View Bookmarks')
    expect(page).to have_content('http://google.com')
  end
end

feature 'error' do
  scenario 'is not a real url' do
    visit('/')
    click_button('Create Bookmark')
    fill_in 'url', with: 'ht://google.com'
    click_button('Save')
    # expect(page).not_to have_content('not a real url')
    expect(page).to have_content "You must submit a valid url"
    end
end
