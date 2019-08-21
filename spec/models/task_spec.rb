require 'rails_helper'

RSpec.describe Task, type: :model do
  before(:all) do
    @task1 = create(:task)
  end

  it "is valid with valid attributes" do
    expect(@task1).to be_valid
  end

  it "is valid with valid attributes" do
    task2 = build(:task, type: 'Issue')
    expect(task2).to be_valid
  end

  it "is not valid without a subject attribute" do
    task2 = build(:task, subject: nil)
    expect(task2).to_not be_valid
  end

  it "is not valid status attribute" do
    task2 = build(:task, status: -1)
    expect(task2).to_not be_valid
  end

  it "is not valid status attribute" do
    task2 = build(:task, status: 4)
    expect(task2).to_not be_valid
  end

  it "is not valid without a status attribute" do
    task2 = build(:task, status: nil)
    expect(task2).to_not be_valid
  end

  it "is valid without a user_id attribute" do
    task2 = build(:task, user_id: nil)
    expect(task2).to be_valid
  end

  it "is valid without a admin_id attribute" do
    task2 = build(:task, admin_id: nil)
    expect(task2).to be_valid
  end
end
