require('spec_helper')

describe('recipe functionality through application', {:type => :feature}) do
  it('allows a user to add a new recipe') do
    visit('/')
    click_link('Recipe view')
    fill_in('recipe_name', :with => "Succatash")
    fill_in('recipe_ingredients', :with => "corn / water / salt")
    fill_in('instructions', :with => "Throw ingredients in pot / Boil / Enjoy")
    click_button('Save')
    expect(page).to have_content('Succatash')
    click_link('Succatash')
    expect(page).to have_content("corn water salt Instruction List Throw ingredients in pot Boil Enjoy")
  end

  it('allows a user to update a recipe') do
    visit('/')
    click_link('Recipe view')
    fill_in('recipe_name', :with => "Succatash")
    fill_in('recipe_ingredients', :with => "corn / water / salt")
    fill_in('instructions', :with => "Throw ingredients in pot / Boil / Enjoy")
    click_button('Save')
    click_link('Succatash')
    click_button('Update')
    fill_in('new_recipe_name', :with => "Sweet Succotash")
    fill_in('new_recipe_ingredient', :with => "white truffle oil")
    fill_in('new_recipe_instruction', :with => "stir")
    click_button('Update')
    expect(page).to have_content('Sweet Succotash')
    expect(page).to have_content('white truffle oil')
    expect(page).to have_content('stir')
  end


end
