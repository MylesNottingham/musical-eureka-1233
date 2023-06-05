require "rails_helper"

RSpec.describe "the recipes show page" do
  let!(:recipe_1) { Recipe.create!(name: "Meatball Sub", complexity: 2, genre: "Italian") }
  let!(:recipe_2) { Recipe.create!(name: "Grilled Cheese", complexity: 1, genre: "American") }

  let!(:ingredient_1) { Ingredient.create!(name: "Ground Beef", cost: 3) }
  let!(:ingredient_2) { Ingredient.create!(name: "Bread", cost: 1) }
  let!(:ingredient_3) { Ingredient.create!(name: "Cheese", cost: 2) }
  let!(:ingredient_4) { Ingredient.create!(name: "Marinara Sauce", cost: 1) }

  let!(:recipe_ingredient_1) { RecipeIngredient.create!(recipe: recipe_1, ingredient: ingredient_1) }
  let!(:recipe_ingredient_2) { RecipeIngredient.create!(recipe: recipe_1, ingredient: ingredient_2) }
  let!(:recipe_ingredient_3) { RecipeIngredient.create!(recipe: recipe_1, ingredient: ingredient_3) }
  let!(:recipe_ingredient_4) { RecipeIngredient.create!(recipe: recipe_1, ingredient: ingredient_4) }

  let!(:recipe_ingredient_5) { RecipeIngredient.create!(recipe: recipe_2, ingredient: ingredient_2) }
  let!(:recipe_ingredient_6) { RecipeIngredient.create!(recipe: recipe_2, ingredient: ingredient_3) }

  context "recipe 1 show page" do
    before(:each) do
      visit recipe_path(recipe_1)
    end

    it "lists the recipe's name, complexity, and genre" do
      within "#page_title" do
        expect(page).to have_content(recipe_1.name)
        expect(page).to have_content("Complexity: #{recipe_1.complexity}")
        expect(page).to have_content("Genre: #{recipe_1.genre}")
        expect(page).to_not have_content(recipe_2.name)
      end
    end

    it "lists the recipe's ingredients" do
      within "#ingredients" do
        expect(page).to have_content("Ingredients:")

        expect(page).to have_content(ingredient_1.name)
        expect(page).to have_content(ingredient_2.name)
        expect(page).to have_content(ingredient_3.name)
        expect(page).to have_content(ingredient_4.name)
      end
    end

    it "lists the total cost of the recipe" do
      within "#total_cost" do
        expect(page).to have_content("Total Cost: $7")
      end
    end
  end

  context "recipe 2 show page" do
    before(:each) do
      visit recipe_path(recipe_2)
    end

    it "lists the recipe's name, complexity, and genre" do
      within "#page_title" do
        expect(page).to have_content(recipe_2.name)
        expect(page).to have_content("Complexity: #{recipe_2.complexity}")
        expect(page).to have_content("Genre: #{recipe_2.genre}")
        expect(page).to_not have_content(recipe_1.name)
      end
    end

    it "lists the recipe's ingredients" do
      within "#ingredients" do
        expect(page).to have_content("Ingredients:")

        expect(page).to have_content(ingredient_2.name)
        expect(page).to have_content(ingredient_3.name)

        expect(page).to_not have_content(ingredient_1.name)
        expect(page).to_not have_content(ingredient_4.name)
      end
    end

    it "lists the total cost of the recipe" do
      within "#total_cost" do
        expect(page).to have_content("Total Cost: $3")
      end
    end

    it "displays a form to add an ingredient to the recipe" do
      within "#add_ingredient" do
        expect(page).to have_content("Add an Ingredient to this Recipe by Ingredient ID")
        expect(page).to have_field(:ingredient_id)
        expect(page).to have_button("Submit")
      end

      fill_in :ingredient_id, with: ingredient_1.id
      click_button "Submit"

      expect(current_path).to eq(recipe_path(recipe_2))

      within "#ingredients" do
        expect(page).to have_content(ingredient_1.name)
      end

      within "#total_cost" do
        expect(page).to have_content("Total Cost: $6")
      end
    end
  end
end
