require('spec_helper')

describe('ingredient functionality through application', {:type => :feature}) do
  it('allows a user to add a new ingredient') do
    visit('/')
    click_link('Ingredient view')
    fill_in('ingredient_name', :with => 'alfalfa sprouts')
    click_button('Save')
    expect(page).to have_content('alfalfa sprouts')
  end
  it('allows a user to update an ingredient name') do
    visit('/')
    click_link('Ingredient view')
    fill_in('ingredient_name', :with => 'alfalfa sprouts')
    click_button('Save')
    click_link('alfalfa sprouts')
    click_button('Update')
    fill_in('new_ingredient_name', :with => "blue alfalfa sprouts")
    click_button('Update Ingredient')
    expect(page).to have_content('blue alfalfa sprouts')
  end

end
