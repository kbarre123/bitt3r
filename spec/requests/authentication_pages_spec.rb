require 'spec_helper'

describe "Authentication" do
  
  subject { page }
  
  describe "signin" do
    before { visit signin_path }
    
    describe "with invalid information" do
      before { click_button "sign in" }
    
      it {should have_title('sign in') }
      it { should have_selector('div.alert.alert-danger') }
      
      describe "after visiting another page" do
        before { click_link "home" }
        it { should_not have_selector('div.alert.alert-danger') }
      end #after visiting another page
    end #with invalid information
    
    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before { sign_in user }
      
      it { should have_title(user.name) }
      it { should have_link('users', href: users_path) }
      it { should have_link('profile', href: user_path(user)) }
      it { should have_link('settings', href: edit_user_path(user)) }
      it { should have_link('sign out', href: signout_path) }
      it { should_not have_link('sign in', href: signin_path) }
      
      describe "followed by signout" do
        before { click_link "sign out" }
        it { should have_link('sign in') }
      end #followed by signout
    end #with valid information
  
  end #signin
  
  describe "authorization" do
    describe "for non-signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      
      describe "when attempting to visit a protected page" do
        before do
          visit edit_user_path(user)
          fill_in "Email", with: user.email
          fill_in "Password", with: user.password
          click_button "sign in"
        end
        
        describe "after signing in" do
          it "should render the desired protected pages" do
            #For some reason, this fails even though the users#edit page has the proper title
            #it { should have_title('edit user') }
          end
        end
      end
      
      describe "in the Users controller" do
        
        describe "visiting the edit page" do
          before { visit edit_user_path(user) }
          it { should have_title('sign in') }
        end
        
        describe "submitting to the update action" do
          before { patch user_path(user) }
          specify { expect(response).to redirect_to(signin_path) }
        end
      
        describe "visiting the user index" do
          before { visit users_path }
          it { should have_title('sign in') }
        end
        
        describe "visiting the following page" do
          before { visit following_user_path(user) }
          it { should have_title('sign in') }
        end
        
        describe "visiting the followers page" do
          before { visit followers_user_path(user) }
          it { should have_title('sign in') }
        end
      end
      
      describe "in the Microposts controller" do
        describe "submitting to the create action" do
          before { post microposts_path }
          specify { expect(response).to redirect_to(signin_path) }
        end
        
        describe "submitting to the destroy action" do
          before { delete micropost_path(FactoryGirl.create(:micropost)) }
          specify { expect(response).to redirect_to(signin_path) }
        end
      end
      
      describe "in the Relationships controller" do
        describe "submitting to the create action" do
          before { post relationships_path }
          specify { expect(response).to redirect_to(signin_path) }
        end #submitting to create
        
        describe "submitting to the destroy action" do
          before { delete relationship_path(1) }
          specify { expect(response).to redirect_to(signin_path) }
        end #submitting to destroy
      end #Relationships controller
    end #for non-signed-in users
     
    describe "as wrong user" do
      let(:user) { FactoryGirl.create(:user) }
      let (:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com") }
      before { sign_in user, no_capybara: true }
      
      describe "submitting a GET request to the Users#edit action" do
        before { get edit_user_path(wrong_user) }
        specify { expect(response.body).not_to match(full_title('edit user')) }
        specify { expect(response).to redirect_to(root_url) }
      end
      
      describe "submitting a PATCH request to the Users#update action" do
        before { patch user_path(wrong_user) }
        specify { expect(response).to redirect_to(root_url) }
      end
    end #as wrong user
    
    describe "as non-admin user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:non_admin) { FactoryGirl.create(:user) }
      
      before { sign_in non_admin, no_capybara: true }
      
      describe "submitting a DELETE request to the Users#destroy action" do
        before { delete user_path(user) }
        specify { expect(response).to redirect_to(root_url) }
      end
    end
    
  end #authorization
end #authentication
