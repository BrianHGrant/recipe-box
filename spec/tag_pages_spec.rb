require('spec_helper')

describe('tag functionality through application', {:type => :feature}) do
  it('allows a user to add a tag to a recipe') do
    visit('/')
    click_link('Tag view')
    fill_in('tag_name', :with => "dessert")
    click_button('Save')
    expect(page).to have_content('dessert')
  end
  it('allows a user to update a tag name') do
    visit('/')
    click_link('Tag view')
    fill_in('tag_name', :with => "dessert")
    click_button('Save')
    click_link('dessert')
    click_button('Update')
    fill_in('new_tag_name', :with => "late-night dessert")
    click_button('Update Tag')
    expect(page).to have_content('late-night dessert')
  end
  it('allows a user to delete a tag') do
    visit('/')
    click_link('Tag view')
    fill_in('tag_name', :with => "dessert")
    click_button('Save')
    click_link('dessert')
    click_button('Update')
    click_button('Delete Tag')
    expect(page).to have_content("No Tags at this time.")
  end

end
