require 'rails_helper'

RSpec.describe Member, type: :model do
  describe 'associations' do
    it { should belong_to(:team) }
    it { should have_many(:members_projects).dependent(:destroy) }
    it { should have_many(:projects).through(:members_projects) }
  end

  describe 'validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
  end
end
