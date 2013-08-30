require 'spec_helper'

describe "Authentication" do

  subject { page }

  describe "sign in page" do
    before { visit login_path }

    describe "with invalid information" do
      before { click_button "Sign in" }

      it { should have_content('Sign in') }
      it { should have_selector('div.alert.alert-error', text: 'Invalid') }
    end
  end
end
