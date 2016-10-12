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
    it "shows post when the post exists" do
      create(:category)
      create(:post, title: "Test post")

      visit post_path(:id => 1)

      expect(page).to have_content("Test post")
    end
    it "returns 404 when post does not exist" do
      visit post_path(:id => 1)
      expect(page.status_code).to eq(404)
    end
  end
  
  describe "GET #new" do
    it "renders the :new template if user is signed in" do
      visit root_path
      page.click_link 'Sign up'
      page.fill_in 'Email', :with => "test@email.com"
      page.fill_in 'Password', :with => "123456"
      page.fill_in 'Password confirmation', :with => "123456"
      page.click_button 'Sign up'
      visit new_post_path
      expect(page).to have_content("New post")
    end
    it "renders 'You need to sign in' message if user in not signed in" do
      visit new_post_path
      expect(page).to have_content("You need to sign in or sign up before continuing")
    end
  end
  
  describe "POST #create" do
    before :each do
      create(:category, name: 'Cats')
      visit root_path
      page.click_link 'Sign up'
      page.fill_in 'Email', :with => "test@email.com"
      page.fill_in 'Password', :with => "123456"
      page.fill_in 'Password confirmation', :with => "123456"
      page.click_button 'Sign up'
      visit new_post_path
    end
    context "with valid attributes" do
      it "saves the new post in the database" do
        page.select 'Cats', :from => 'Category'
        page.fill_in 'Title', :with => "Test title"
        page.fill_in 'Text', :with => "Test text"
        page.click_button "Submit"
        expect(page).to have_current_path(post_path(id: Post.first.slug))
      end
    end
    
    context "with invalid attributes" do
      it "does not save the new post in the database" do
        page.click_button "Submit"
        expect(Post.exists?).to be_falsey
      end
      it "re-renders the :new template" do
        page.click_button "Submit"
        expect(page).to have_content("New post")
      end
    end
  end
end