require 'spec_helper'

describe "Authentication" do
  
  subject { page }
  
  describe "signin" do
    before { visit signin_path }
    
    describe "with invalid information" do
      before { click_button "sign in" }
    
      it {should have_title('sign in') }
      it { should have_selector('div.alert.alert-error') }
      
      describe "after visiting another page" do
        before { click_link "home" }
        it { should_not have_selector('div.alert.alert-error') }
      end #after visiting another page
    end #with invalid information
    
    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        fill_in "Email", with: user.email.upcase
        fill_in "Password", with: user.password
        click_button "sign in"
      end #before
      
      it { should have_title(user.name) }
      it { should have_link('profile', href: user_path(user)) }
      it { should have_link('sign out', href: signout_path) }
      it { should_not have_link('sign in', href: signin_path) }
      
      describe "followed by signout" do
        before { click_link "sign out" }
        it { should have_link('sign in') }
      end #followed by signout
    end #with valid information
  
  end #signin
end #authentication
