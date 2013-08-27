require 'spec_helper'

describe "StaticPages" do
  describe "visit /tracking/menu" do
    it "should just exist!" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      visit '/tracking/menu'
      expect(page).to have_content('Product')
    end
  end
end
