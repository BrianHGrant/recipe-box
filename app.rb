require('bundler/setup')
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
    recipe.ingredients.push(ingredient)
  end
  redirect('/recipes')
end
