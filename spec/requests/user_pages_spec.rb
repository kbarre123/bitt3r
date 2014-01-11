require 'spec_helper'

describe "User pages" do
  
  subject { page }
  
  describe "index" do
    
    let(:user) { FactoryGirl.create(:user) }
    
    before do
      sign_in user
      visit users_path
    end
    
    it { should have_title('all users') }
    it { should have_content('all users') }
    
    describe "pagination" do
      before(:all) { 30.times { FactoryGirl.create(:user) } }
      after(:all) { User.delete_all }
      
      it { should have_selector('div.pagination') }
      
      it "should list each user" do
        User.paginate(page: 1).each do |user|
          expect(page).to have_selector('li', text: user.name)
        end
      end
    end
    
    describe "delete links" do
      it { should_not have_link('delete') }
      
      describe "as an admin user" do
        let(:admin) { FactoryGirl.create(:admin) }
        before do
          sign_in admin
          visit users_path
        end
        
        it { should have_link('delete', href: user_path(User.first)) }
        it "should be able to delete another use" do
          expect do
            click_link('delete', match: :first)
          end.to change(User, :count).by(-1)
        end
        it { should_not have_link('delete', href: user_path(admin)) }
      end
    end
    
    it "should list each user" do
      User.all.each do |user|
        expect(page).to have_selector('li', text: user.name)
      end
    end
  end
  
  describe "signup page" do
    before {visit signup_path }
    
    let(:submit) { "create my account" }
    
    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end
    
    describe "with valid information" do
      before do
        fill_in "Name", with: "Example User"
        fill_in "Email", with: "user@example.com"
        fill_in "Password", with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end
      
      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
      
      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by(email: 'user@example.com') }
        
        it { should have_link('sign out') }
        it { should have_title(user.name) }
        it { should have_selector('div.alert.alert-success', text: 'welcome') }
      end
    end
    
    it { should have_content('sign up') }
    it { should have_title('sign up') }
  end
  
  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    let!(:m1) { FactoryGirl.create(:micropost, user: user, content: "Foo") }
    let!(:m2) { FactoryGirl.create(:micropost, user: user, content: "Bar") }
    
    before { visit user_path(user) }
    
    it { should have_content(user.name) }
    it { should have_title(user.name) }
    
    describe "microposts" do
      it { should have_content(m1.content) }
      it { should have_content(m2.content) }
      it { should have_content(user.microposts.count) }
    end
    
    describe "follow/unfollow buttons" do
      let(:other_user) { FactoryGirl.create(:user) }
      before { sign_in user }
      
      describe "following a user" do
        before { visit user_path(other_user) }
        
        it "should increment the followed user count" do
          expect do
            click_button "follow"
          end.to change(user.followed_users, :count).by(1)
        end #should increment the followed user count
        
        it "should increment the other user's followers count" do
          expect do
            click_button "follow"
          end.to change(other_user.followers, :count).by(1)
        end #should increment the other user's followers count
        
        describe "toggling the button" do
          before { click_button "follow" }
          it { should have_xpath("//input[@value='unfollow']") }
        end #toggling the button
      end #following a user
      
      describe "unfollowing a user" do
        before do
          user.follow!(other_user)
          visit user_path(other_user)
        end
        
        it "shouldn't decrement the followed user count" do
          expect do
            click_button "unfollow"
          end.to change(user.followed_users, :count).by(-1)
        end #shouldn't increment the followed user count
        
        it "should decrement the other user's followers count" do
          expect do
            click_button "unfollow"
          end.to change(other_user.followers, :count).by(-1)
        end #should decrement the other user's followers count
        
        describe "toggling the button" do
          before { click_button "unfollow" }
          it { should have_xpath("//input[@value='follow']") }
        end #toggling the button
      end #following a user
      
    end #follow/unfollow buttons
  end #profile page
  
  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    
    before do
      sign_in user
      visit edit_user_path(user)
    end #before
    
    describe "page" do
      it { should have_content("update your profile") }
      it { should have_title('edit user') }
      it { should have_link('change', href: 'http://gravatar.com/emails') }
    end
    
    describe "with invalid information" do
      before { click_button "save changes" }
      
      it { should have_content('error') }
    end
    
    describe "with valid information" do
      let(:new_name) { "New Name" }
      let(:new_email) { "new@example.com" }
      before do
        fill_in "Name", with: new_name
        fill_in "Email", with: new_email
        fill_in "Password", with: user.password
        fill_in "Confirm Password", with: user.password
        click_button "save changes"
      end
      
      it { should have_title(new_name) }
      it { should have_selector('div.alert.alert-success') }
      it { should have_link('sign out', href: signout_path) }
      specify { expect(user.reload.name).to eq new_name }
      specify { expect(user.reload.email).to eq new_email }
    end
  end
  
  describe "following/followers" do
    let(:user) { FactoryGirl.create(:user) }
    let(:other_user) { FactoryGirl.create(:user) }
    before { user.follow!(other_user) }
    
    describe "followed users" do
      before do
        sign_in user
        visit following_user_path(user)
      end
      
      it { should have_title(full_title('following')) }
      it { should have_selector('h3', text: 'following') }
      it { should have_link(other_user.name, href: user_path(other_user)) }
    end
    
    describe "followers" do
      before do
        sign_in other_user
        visit followers_user_path(other_user)
      end
      
      it { should have_title(full_title('followers')) }
      it { should have_selector('h3', text: 'followers') }
      it { should have_link(user.name, href: user_path(user)) }
    end
  end
end
