require "rails_helper"

RSpec.describe PostsController, :type => :feature do
  describe "GET #index" do
    context "when params[:category_id] == category_id" do
      before :each do
        create(:category, name: "Cats")
        create(:category, name: "Dogs")
        create(:post, category_id: 1)
        create(:post, category_id: 2)
      end
      it "filters results by category" do
        visit posts_path(:category_id => 1)
        expect(page.find('.label-default').text).to eq("Cats")
        expect(page).to have_selector('.label-default', count: 1)
      end
      it "returns all posts when no category_id is given" do
        visit posts_path
        expect(page).to have_selector('.label-default', count: 2)
      end
      it "returns no posts when wrong category_id is given" do
        visit posts_path(:category_id => 3)
        expect(page).to have_selector('.label-default', count: 0)
      end
    end
  end
  
  describe "GET #show" do
    it "renders the :show template"
  end
  
  describe "GET #new" do
    it "renders the :new template"
  end
  
  describe "POST #create" do
    context "with valid attributes" do
      it "saves the new post in the database"
      it "redirects to the home page"
    end
    
    context "with invalid attributes" do
      it "does not save the new post in the database"
      it "re-renders the :new template"
    end
  end
end