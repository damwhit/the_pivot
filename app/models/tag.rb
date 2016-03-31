class Tag < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validate :name_is_not_a_category

  has_many :taggings
  has_many :events, through: :taggings

  def name_is_not_a_category
    names = Category.all.pluck(:name)
    if names.include? name
      errors.add(:tag, "must not have the same name as a category")
    end
  end
end
