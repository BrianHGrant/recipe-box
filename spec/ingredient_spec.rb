require('spec_helper')

describe(Ingredient) do
  it('belongs to a recipe') do
    test_recipe = Recipe.create({:name => "Pot Roast"})
    test_ingredient = Ingredient.create({:name => "carrots"})
    test_recipe.ingredients.push(test_ingredient)
    expect(test_recipe.ingredients()).to(eq([test_ingredient]))
  end
end
