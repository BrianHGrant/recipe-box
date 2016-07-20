require('spec_helper')

describe(Recipe) do
  it('has many ingredients') do
    test_recipe = Recipe.create({:name => "Pot Roast"})
    test_ingredient = Ingredient.create({:name => "carrots"})
    test_ingredient2 = Ingredient.create({:name => "potatos"})
    test_recipe.ingredients.push(test_ingredient)
    test_recipe.ingredients.push(test_ingredient2)
    expect(test_recipe.ingredients()).to(eq([test_ingredient, test_ingredient2]))
  end
end
