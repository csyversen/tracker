require 'spec_helper'

describe "Authentication" do

  subject { page }

  describe "sign in page" do
    before { visit login_path }


    it { should have_content('Sign in') }
    it { should have_title('Sign in') }
  end
end
