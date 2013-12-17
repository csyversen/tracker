require 'spec_helper'

describe "Products" do
  subject { page }
  describe "GET /products" do
    # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
    before { visit products_path }

    # Not logged in, so no home/users link
    it { should have_link( "Products", href: products_path ) }
    it { should have_link( "Login", href: root_path ) }

    it { should have_content("All products") }
  end
end
