require 'spec_helper'

describe "StaticPages" do
  
  subject { page }
  
  shared_examples_for "all static pages" do
    it { should have_selector('h1', text: heading) }
    it { should have_title(full_title(page_title)) }
  end
  
  describe "Home page" do
    before { visit root_path }
    
    it { should have_content('bitt3r') }
    it { should have_title('') }
    it { should_not have_title(' | home') } 
  end
  
  describe "Help page" do
    before {visit help_path}
   
    it { should have_content('help') }
    #it { should have_title('help') }
  end
  
  describe "About page" do
    before {visit about_path}
   
    it { should have_content('about') }
    #it { should have_title('about') }
  end
  
  describe "Contact page" do
    before {visit contact_path}
   
    it { should have_content('contact') }
    #it { should have_title('contact') }
  end
end
