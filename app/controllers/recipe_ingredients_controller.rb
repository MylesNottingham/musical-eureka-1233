class RecipeIngredientsController < ApplicationController
  def create
    recipe = Recipe.find(params[:recipe_id])
    ingredient = Ingredient.find(params[:ingredient_id])

    RecipeIngredient.create!(recipe: recipe, ingredient: ingredient)
    redirect_to recipe_path(recipe)
  end
end
