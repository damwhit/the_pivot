require "rails_helper"

RSpec.describe Tag, type: :model do
  it { should validate_presence_of :name }
  it { should validate_uniqueness_of :name }

  it "should not have the same name as a category" do
    category = Category.create(name: "sports")
    tag = Tag.new(name: "sports")

    expect(tag.valid?).to be false
  end
end
