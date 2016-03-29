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

require 'rails_helper'

RSpec.describe Comment, type: :model do
  it { should validate_presence_of :comment }
  it { should validate_presence_of :order_id }

  it { should belong_to :order }
end
