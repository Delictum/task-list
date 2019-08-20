require 'rails_helper'

RSpec.describe Comment, type: :model do
  before(:all) do
    @comment1 = create(:comment)
  end

  it "is valid with valid attributes" do
    expect(@comment1).to be_valid
  end

  it "is not valid without a text" do
    comment2 = build(:comment, comment_text: nil)
    expect(comment2).to_not be_valid
  end

  it "is valid with reply attribute" do
    comment2 = build(:comment, reply_id: @comment1.reply_id)
    expect(comment2).to be_valid
  end
end
