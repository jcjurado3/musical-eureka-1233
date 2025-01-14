# User Story 2 - Recipes Show

# As a visitor,
# When I visit '/recipes/:id',
# Then I see the recipe's name, complexity and genre,
# and I see a list of the names of the ingredients for the recipe.


require "rails_helper"

RSpec.describe "Recipes show Page" do 
  describe "/recipes/:id" do
    before(:each) do
      @rec1 = Recipe.create!(name: "Tacos", complexity: 5, genre: "Mexican")
      @ing1 = Ingredient.create!(name: "Ground Beef", cost: 2)
      @ing2 = Ingredient.create!(name: "Salt", cost: 4)
      @recing1 = RecipeIngredient.create!(recipe_id: @rec1.id, ingredient_id: @ing1.id)
      @recing1 = RecipeIngredient.create!(recipe_id: @rec1.id, ingredient_id: @ing2.id)


      @rec2 = Recipe.create!(name: "Hotdog", complexity: 2, genre: "American")
      @ing2 = Ingredient.create!(name: "Lettuce", cost: 8)
      @recing2 = RecipeIngredient.create!(recipe_id: @rec2.id, ingredient_id: @ing2.id)

      @rec3 = Recipe.create!(name: "Fried Rice", complexity: 6, genre: "Chinese")
      @ing3 = Ingredient.create!(name: "Lettuce", cost: 8)

    end

    it "displays recipe's name, complexity and genre" do
      visit "/recipes/#{@rec1.id}"

      expect(page).to have_content("Tacos")
      expect(page).to_not have_content("Hotdog")

      expect(page).to have_content("Complexity: #{@rec1.complexity}")
      expect(page).to_not have_content("Complexity: #{@rec2.complexity}")

      expect(page).to have_content("#{@recing1.ingredient.name}")
      expect(page).to_not have_content("#{@recing2.ingredient.name}")
    end

    it "should display the total cost of all ingredients" do
      # User Story 3 - Total Cost

# As a visitor,
# When I visit '/recipes/:id'
# I see the total cost of all of the ingredients in the recipe.
# (e.g. "Total Cost: 22")

    visit "/recipes/#{@rec1.id}"

    expect(page).to have_content("Total Cost: 6")
    end
  end
end