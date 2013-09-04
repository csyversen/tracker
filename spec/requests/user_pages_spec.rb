require 'spec_helper'

describe "UserPages" do

  subject { page }

  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit edit_user_path(user) }

    describe "page" do
      it { should have_content('Update your profile') }
      it { should have_link("change", href: "http://gravatar.com/emails") }
    end

    describe "with invalid info" do
      before { click_button "Save" }
      it { should have_content("error") }
    end
  end
end
