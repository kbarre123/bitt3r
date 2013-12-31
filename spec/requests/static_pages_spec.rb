require 'spec_helper'

describe "StaticPages" do
  
  describe "Home page" do
    it "should have the content 'bitt3r'" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      visit '/static_pages/home'
      expect(page).to have_content('bitt3r')
    end
  end
  
  describe "Help page" do
    it "should have the content 'help'" do
      visit '/static_pages/help'
      expect(page).to have_content('help')
    end
  end
  
  describe "About page" do
    it "should have the content 'about'" do
      visit '/static_pages/about'
      expect(page).to have_content('about')
    end
  end
  
end
