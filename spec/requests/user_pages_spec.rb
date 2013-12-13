require 'spec_helper'

describe "UserPages" do

  subject { page }

  describe "user home" do
    let(:user) { FactoryGirl.create(:user) }

    before { visit login_path }

    before do
      fill_in "Email",      with: user.email.upcase
      fill_in "Password",   with: user.password
      click_button "Sign in"
    end

    #before { visit user_path(user) }

    describe "page" do
      it { should have_link( "Home/Users", href: user_path(user)) }
    end
  end
end

  