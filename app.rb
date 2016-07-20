require('bundler/setup')
require('pry')
Bundler.require(:default)

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

get('/') do
  erb(:index)
end

get('/recipes') do
  @recipes = Recipe.all()
  erb(:recipes)
end

post('/recipes') do
  name = params.fetch("recipe_name")
  instruction = params.fetch("instructions")
  recipe = Recipe.create({:name => name, :instruction => instruction})
  ingredients = params.fetch("recipe_ingredients")
  ingredients_list = ingredients.split(", ")
  ingredients_list.each do |ingredient|
    new_ingredient = Ingredient.new({:name => ingredient})
    recipe.ingredients.push(new_ingredient)
  end
  redirect('/recipes')
end

get('/recipes/:id') do
  @recipe = Recipe.find(params.fetch("id"))
  @instruction_array = @recipe.instruction.split("/")
  erb(:recipe)
end

post('/recipe/:id/update') do
  @recipe = Recipe.find(params.fetch("id"))
  erb(:recipe_update)
end
patch('/recipes/:id') do
  @recipe = Recipe.find(params.fetch('id').to_i)
  recipe_name = params.fetch('new_recipe_name')
  ingredients = params.fetch('new_recipe_ingredient')
  instruction = params.fetch('new_recipe_instruction')
  ingredients_list = ingredients.split(", ")
  ingredients_list.each do |ingredient|
    new_ingredient = Ingredient.new({:name => ingredient})
    @recipe.ingredients.push(new_ingredient)
  end
  @recipe.update({:name => recipe_name, :instruction =>  instruction})
  redirect('/recipes/'.concat(@recipe.id().to_s()))
end

delete('/recipes/:id') do
  recipe = Recipe.find(params.fetch('id').to_i)
  ingredient = Ingredient.find(params.fetch('ingredient_remove').to_i)
  ingredient.recipes.destroy(recipe)
  redirect('/recipes/'.concat(recipe.id().to_s()))

end
