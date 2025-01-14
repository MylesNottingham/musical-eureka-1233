require "rails_helper"

RSpec.describe "the ingredients index page" do
  let!(:ingredient_1) { Ingredient.create!(name: "Ground Beef", cost: 3) }
  let!(:ingredient_2) { Ingredient.create!(name: "Bread", cost: 1) }
  let!(:ingredient_3) { Ingredient.create!(name: "Cheese", cost: 2) }

  before(:each) do
    visit ingredients_path
  end

  it "lists all ingredients and their cost" do
    within "#page-title" do
      expect(page).to have_content("All Ingredients")
    end

    within "#ingredients" do
      expect(page).to have_content(ingredient_1.name)
      expect(page).to have_content("Cost: $#{ingredient_1.cost}")
      expect(page).to have_content(ingredient_2.name)
      expect(page).to have_content("Cost: $#{ingredient_2.cost}")
      expect(page).to have_content(ingredient_3.name)
      expect(page).to have_content("Cost: $#{ingredient_3.cost}")
    end
  end

  it "lists ingredients alphabetically" do
    within "#ingredients" do
      expect(ingredient_2.name).to appear_before(ingredient_3.name)
      expect(ingredient_3.name).to appear_before(ingredient_1.name)
    end
  end
end
