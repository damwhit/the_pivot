# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  first_name      :string
#  last_name       :string
#  email           :string
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  role            :integer          default(0)
#  fullname        :string
#  status          :string           default("active")
#

class User < ActiveRecord::Base
  has_secure_password
  before_save :build_name
  has_many :orders
  has_many :order_products, through: :orders
  has_many :listings

  validates :fullname, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true
  validates :status, presence: true, inclusion: { in: %w(active suspended) }

  enum role: %w(default admin super_admin)

  default_scope -> { order(id: :asc) }

  def build_name
    self.first_name = fullname.split[0]
    self.last_name = fullname.split[1..-1].join(" ")
  end

  def admin_message
    ["Life is good, #{self.first_name}."]
  end

  def name
    "#{first_name} #{last_name}"
  end

  def self.filter_by_status(status)
    status ||= "active"
    if status == "all"
      User.all
    else
      User.where(status: status)
    end
  end
end
