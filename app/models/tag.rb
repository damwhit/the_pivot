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

  def self.names
    pluck(:name)
  end

  def self.valid_tag_name?(tag_name)
    names.include?(tag_name)
  end

  def self.valid_tags(tags)
    valid_tags = []
    tags.split(',').each do |tag|
      if valid_tag_name?(tag.strip)
        valid_tags << Tag.find_by(name: tag.strip)
      end
    end
    valid_tags
  end

  def self.tag_string
    pluck(:name).join(", ")
  end
end
