require "rails_helper"

RSpec.describe Post, :type => :model do
  
  describe "#search", :type => :feature do
  	before :each do
  	  create(:post, text: "Another")
  	  create(:post, title: "Another")
  	end
  	
  	it "returns result when there are posts containing the search term in title" do
  	  posts = Post.search('title')
  	  expect(posts.first.title).to eq("Test title")
  	  expect(posts.count).to eq(1)
  	end
  	it "returns result when there are posts containing the search term in text" do
  	  posts = Post.search('text')
  	  expect(posts.first.text).to eq("Test text")
  	  expect(posts.count).to eq(1)
  	end
  	it "returns no posts when there are no posts containing the search term" do
  	  posts = Post.search('ruby')
  	  expect(posts.count).to eq(0)
  	end

  end

end