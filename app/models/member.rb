class Member < ApplicationRecord
  belongs_to :team
  has_many :members_projects, dependent: :destroy
  has_many :projects, through: :members_projects
  validates_presence_of :first_name, :last_name

  def full_name
    "#{first_name} #{last_name}"
  end
end
