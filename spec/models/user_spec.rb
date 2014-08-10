require 'spec_helper'

describe User do
  before do
    @user = User.new(email: "user@example.net", password: "foobar", password_confirmation: "foobar")
  end

  subject { @user }

  it { should respond_to(:password_confirmation) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:authenticate) }

  describe "password valid/invalid" do
    before { @user.save }
    let(:found_user) { User.find_by(email: @user.email) }

    describe "with valid password" do
      it { should eq found_user.authenticate(@user.password) }
    end
  end

end
