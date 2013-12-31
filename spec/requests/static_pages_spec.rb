require 'spec_helper'

describe "StaticPages" do
  
  describe "Home page" do
    it "should have the content 'bitt3r'" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      visit '/static_pages/home'
      expect(page).to have_content('bitt3r')
    end
    it "should have the title 'Home'" do
      visit '/static_pages/home'
      expect(page).to have_title("bitt3r | Home")
    end
  end
  
  describe "Help page" do
    it "should have the content 'help'" do
      visit '/static_pages/help'
      expect(page).to have_content('help')
    end
    it "should have the title 'Help'" do
      visit '/static_pages/help'
      expect(page).to have_title("bitt3r | Help")
    end
  end
  
  describe "About page" do
    it "should have the content 'about us'" do
      visit '/static_pages/about'
      expect(page).to have_content('about us')
    end
    it "should have the title 'About Us'" do
      visit '/static_pages/about'
      expect(page).to have_title("bitt3r | About Us")
    end
  end
  
end
