require('spec_helper')

describe('recipe functionality through application', {:type => :feature}) do
  it('allows a user to add a new recipe') do
    visit('/')
    click_link('Recipe view')
    fill_in('recipe_name', :with => "Succatash")
    fill_in('recipe_ingredients', :with => "corn, water, salt")
    fill_in('instructions', :with => "1. Throw ingredients in pot. 2. Boil. 3. Enjoy.")
    click_button('Save')
    expect(page).to have_content('Succatash')
    click_link('Succatash')
    expect(page).to have_content("Corn Water Salt Instructions: 1. Throw ingredients in pot. 2. Boil. 3. Enjoy.")
  end
end
