require './bookmark_app.rb'

# As a user
# So I can remove my bookmark from Bookmark Manager
# I want to delete a bookmark

feature 'Deleting a bookmark' do
  scenario 'should delete a bookmark' do
    Bookmarks.create('http://makersacademy.com', 'Maker')
    visit('/')
    click_button('View Bookmarks')
    click_button(id: 'Maker')

    expect(current_path).to eq '/bookmarks'
    expect(page).not_to have_content 'Maker'
  end
end
