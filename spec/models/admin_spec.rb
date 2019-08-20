require 'rails_helper'

RSpec.describe Admin, type: :model do
  before(:all) do
    @admin1 = create(:admin)
  end

  it "is valid with valid attributes" do
    expect(@admin1).to be_valid
  end

  it "has a unique email" do
    @admin2 = build(:admin, email: @admin1.email)
    expect(@admin2).to_not be_valid
  end

  it "is not valid without a password" do
    @admin2 = build(:admin, encrypted_password: nil)
    expect(@admin2).to_not be_valid
  end

  it "is not valid without an email" do
    @admin2 = build(:admin, email: nil)
    expect(@admin2).to_not be_valid
  end
end
