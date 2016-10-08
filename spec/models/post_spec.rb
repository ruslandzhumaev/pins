require "rails_helper"

RSpec.describe Post, :type => :model do
  
  describe "#search", :type => :feature do
  	
  	it "returns result when there are posts containing the search term in title"
  	it "returns result when there are posts containing the search term in text"
  	it "returns search error message when there are no posts containing the search term"

  end

end