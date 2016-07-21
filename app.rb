require('bundler/setup')
require('pry')
Bundler.require(:default)

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

get('/') do
  erb(:index)
end

get('/recipes') do
  @recipes = Recipe.all()
  @tags = Tag.all()
  erb(:recipes)
end

post('/recipes') do
  name = params.fetch("recipe_name")
  instruction = params.fetch("instructions")
  recipe = Recipe.create({:name => name, :instruction => instruction})
  ingredients = params.fetch("recipe_ingredients")
  ingredients_list = ingredients.split("/")
  ingredients_list.each do |ingredient|
    new_ingredient = Ingredient.new({:name => ingredient})
    recipe.ingredients.push(new_ingredient)
  end
  if params[:recipe_tag]
    tag_ids = []
    params[:recipe_tag].each do |tag_id|
      tag_ids.push(tag_id.to_i())
    end
    tag_ids.each do |tag_id|
      Tag.find(tag_id).recipes.push(recipe)
    end
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
  @tags = Tag.all()
  erb(:recipe_update)
end
patch('/recipes/:id') do
  recipe = Recipe.find(params.fetch('id').to_i)
  recipe_name = params.fetch('new_recipe_name')
  ingredients = params.fetch('new_recipe_ingredient')
  instruction = params.fetch('new_recipe_instruction')
  ingredients_list = ingredients.split("/")
  ingredients_list.each do |ingredient|
    new_ingredient = Ingredient.new({:name => ingredient})
    recipe.ingredients.push(new_ingredient)
  end
  recipe.update({:name => recipe_name, :instruction =>  instruction})
  if params[:new_recipe_tag]
    tag_ids = []
    params[:new_recipe_tag].each do |tag_id|
      tag_ids.push(tag_id.to_i())
    end
    tag_ids.each do |tag_id|
      Tag.find(tag_id).recipes.push(recipe)
    end
  end
  redirect('/recipes/'.concat(recipe.id().to_s()))
end

delete('/recipes/:id/ingredient') do
  recipe = Recipe.find(params.fetch('id').to_i)
  ingredient = Ingredient.find(params.fetch('ingredient_remove').to_i)
  ingredient.recipes.destroy(recipe)
  redirect('/recipes/'.concat(recipe.id().to_s()))
end

delete('/recipes/:id/tag') do
  recipe = Recipe.find(params.fetch('id').to_i)
  tag = Tag.find(params.fetch('tag_remove').to_i)
  tag.recipes.destroy(recipe)
  redirect('/recipes/'.concat(recipe.id().to_s))
end

delete('/recipes/:id') do
  recipe = Recipe.find(params.fetch('id').to_i)
  recipe.delete()
  redirect('/recipes')
end

get('/ingredients') do
  @ingredients = Ingredient.all()
  erb(:ingredients)
end

get('/ingredients/:id') do
  @ingredient = Ingredient.find(params.fetch("id").to_i)
  erb(:ingredient)
end

post('/ingredients') do
  name = params.fetch("ingredient_name")
  new_ingredient = Ingredient.create({:name => name})
  redirect('/ingredients')
end

post('/ingredients/:id/update') do
  @ingredient = Ingredient.find(params.fetch("id").to_i)
  erb(:ingredient_update)
end

patch('/ingredients/:id') do
  name = params.fetch('new_ingredient_name')
  @ingredient = Ingredient.find(params.fetch('id').to_i)
  @ingredient.update({:name => name})
  redirect('/ingredients/'.concat(@ingredient.id().to_s))
end

get('/tags') do
  @tags = Tag.all()
  erb(:tags)
end

post('/tags') do
  name = params.fetch('tag_name')
  new_tag = Tag.create({:name => name})
  redirect('/tags')
end

get('/tags/:id') do
  @tag = Tag.find(params.fetch('id').to_i)
  erb(:tag)
end

post('/tags/:id/update') do
  @tag = Tag.find(params.fetch('id').to_i)
  erb(:tag_update)
end

patch('/tags/:id') do
  name = params.fetch('new_tag_name')
  @tag = Tag.find(params.fetch('id').to_i)
  @tag.update({:name => name})
  redirect('/tags/'.concat(@tag.id().to_s))
end
