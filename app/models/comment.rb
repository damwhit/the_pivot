# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  order_id   :integer
#  comment    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Comment < ActiveRecord::Base
  belongs_to :order

  validates :order_id, presence: true
  validates :comment, presence: true

  def date
    created_at.strftime("%B %-d, %Y")
  end
end
