require('spec_helper')


describe('recipe functionality through application', {:type => :feature}) do
  it('allows a user to add a new recipe') do
    Tag.create({:name => "soups"})
    visit('/')
    click_link('Recipe view')
    fill_in('recipe_name', :with => "Succatash")
    fill_in('recipe_ingredients', :with => "corn / water / salt")
    check('recipe_tag[]')
    fill_in('instructions', :with => "Throw ingredients in pot / Boil / Enjoy")
    click_button('Save')
    expect(page).to have_content('Succatash')
    click_link('Succatash')
    expect(page).to have_content("corn water salt Instruction List Throw ingredients in pot Boil Enjoy Tags List soups")
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
  it('allows the user to delete a recipe') do
    visit('/')
    click_link('Recipe view')
    fill_in('recipe_name', :with => "Succatash")
    fill_in('recipe_ingredients', :with => "corn / water / salt")
    fill_in('instructions', :with => "Throw ingredients in pot / Boil / Enjoy")
    click_button('Save')
    click_link('Succatash')
    click_button('Update')
    click_button('Delete Recipe')
    expect(page).to have_content('No recipes at this time. Add a recipe below.')
  end
  it('allows the user to remove an ingredient from recipe') do
    visit('/')
    click_link('Recipe view')
    fill_in('recipe_name', :with => "Succatash")
    fill_in('recipe_ingredients', :with => "corn / water / salt")
    fill_in('instructions', :with => "Throw ingredients in pot / Boil / Enjoy")
    click_button('Save')
    click_link('Succatash')
    click_button('Update')
    select('water', :from => 'ingredient_remove')
    click_button('Remove ingredient')
    expect(page).to have_content('corn salt')
  end

  it('allows the user to remove a tag from a recipe') do
    Tag.create({:name => "soups"})
    visit('/')
    click_link('Recipe view')
    fill_in('recipe_name', :with => "Succatash")
    fill_in('recipe_ingredients', :with => "corn / water / salt")
    check('recipe_tag[]')
    fill_in('instructions', :with => "Throw ingredients in pot / Boil / Enjoy")
    click_button('Save')
    click_link('Succatash')
    click_button('Update')
    select('soups', :from => 'tag_remove')
    click_button('Remove Tag')
    expect(page).to have_no_content('soups')
  end

end
