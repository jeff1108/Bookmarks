require './bookmark_app.rb'

# As a user
# So I can change a bookmark in Bookmark Manager
# I want to update a bookmark
feature 'update' do
  scenario "should update a bookmark" do
    visit('/bookmarks/new')
    fill_in 'url', with: 'http://nba.com'
    fill_in 'title', with: 'Nba'
    click_button('Save')
    click_button('View Bookmark')
    click_button(id: 'Update Nba')

    fill_in('url', with: 'http://www.snakersacademy.com')
    fill_in('title', with: 'Snakers Academy')
    click_button('Submit')

    expect(current_path).to eq '/bookmarks'
    expect(page).not_to have_content 'Nba'
    expect(page).to have_content 'Snakers Academy'
  end
end
