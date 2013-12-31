require 'spec_helper'

describe "StaticPages" do
  describe "Home page" do
    it "should have the content 'bitt3r'" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      visit '/static_pages/home'
      expect(page).to have_content('bitt3r')
    end
  end
end
