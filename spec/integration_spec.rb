require('spec_helper')

describe('recipe functionality through application', {:type => :feature}) do
  it('allows a user to add a new recipe') do
    visit('/')
    click_link('Recipe view')
    fill_in('recipe_name', :with => "Succatash")
    fill_in('recipe_ingredients', :with => "corn, water, salt")
    fill_in('instructions', :with => "Throw ingredients in pot / Boil / Enjoy")
    click_button('Save')
    expect(page).to have_content('Succatash')
    click_link('Succatash')
    expect(page).to have_content("corn water salt Instruction List Throw ingredients in pot Boil Enjoy")
  end
end
