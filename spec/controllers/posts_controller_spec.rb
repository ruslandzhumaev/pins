require "rails_helper"

describe PostsController do
  describe "GET #index" do
    it "renders the :index view"
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