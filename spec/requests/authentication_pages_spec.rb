require 'spec_helper'

describe "Authentication" do

  subject { page }

  describe "signin" do
    before { visit signin_path }

    it { should have_content('Sign In') }
    it { should have_title('Sign In') }

 	  describe "with invalid information" do
      before { click_button "Sign In" }

      it { should have_title('Sign In') }
      it { should have_error_message('Invalid') }
      #it { should have_selector('div.alert.alert-error') }
      #commented code was defined by a custom matcher in utilities.rb

      describe "after visiting another page" do
        before { click_link "Home" }
        it { should_not have_selector('div.alert.alert-error') }
      end
    end

    describe "with valid information" do
    	let (:user) { FactoryGirl.create(:user) }
    	before { valid_signin(user) }
      # before do
    	# 	fill_in "Email", with: user.email.upcase
    	# 	fill_in "Password", with: user.password
    	# 	click_button "Sign In"
      #commented code was put into a helper in utilities.rb
    	end

    	it { should have_title(user.name) }
    	it { should have_link('Profile', href: user_path(user)) }
    	it { should have_link('Sign Out', href: signout_path) }
    	it {should_not have_link('Sign In', href: signin_path) }
    end
  end
end