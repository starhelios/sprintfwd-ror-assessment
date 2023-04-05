class Project < ApplicationRecord
  has_many :members_projects, dependent: :destroy
  has_many :members, through: :members_projects
  validates_presence_of :name
end
