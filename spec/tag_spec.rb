require('spec_helper')

describe(Tag) do
  it('has many recipes') do
    test_recipe1 = Recipe.create({:name => "Pot Roast"})
    test_recipe2 = Recipe.create({:name => "Greek Salad"})
    test_tag = Tag.create({:name => 'Entree'})
    test_tag.recipes.push(test_recipe1)
    test_tag.recipes.push(test_recipe2)
    expect(test_tag.recipes()).to(eq([test_recipe1, test_recipe2]))
  end
end
