require 'spec_helper'

describe "Authentication" do

  subject { page }

  describe "sign in page" do
    before { visit login_path }

    describe "with invalid information" do
      before { click_button "Sign in" }

      it { should have_content('Sign in') }
      it { should have_selector('div.alert.alert-error', text: 'Invalid') }

      describe "after visiting anotehr page" do
        before { click_link "Home" }
        it { should_not have_selector('div.alert.alert-error') }
      end
    end

    describe "with valid info!" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        fill_in "Email",      with: user.email.upcase
        fill_in "Password",   with: user.password
        click_button "Sign in"
      end

      it { should have_link('Logout',   href: logout_path) }
      it { should_not have_link('Login', href: login_path) }

      describe "followed by logout" do
        before { click_link "Logout" }
        it { should have_link("Login") }
      end

    end
  end
end
