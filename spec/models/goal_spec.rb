require 'rails_helper'

RSpec.describe Goal, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:detail) }
    it { should_not allow_value(nil).for(:completed) }
    it { should_not allow_value(nil).for(:public) }
  end

  describe 'associations' do
  end

  describe 'class methods' do
  end
end
