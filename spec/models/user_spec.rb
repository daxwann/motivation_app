require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { FactoryBot.build(:user, password: "password") }

  describe 'validations' do
    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:password_digest) }
    it { should validate_presence_of(:session_token) }
    it { should validate_length_of(:password).is_at_least(6) }
  end

  describe 'associations' do
  end

  describe 'class methods' do
    describe '::find_by_credentials' do
      before { user.save! }
      it 'returns nil with incorrect credentials' do
        expect(User.find_by_credentials(user.username, 'abc')).to eq(nil)
      end

      it 'returns user with correct credentials' do
        expect(User.find_by_credentials(user.username, 'password')).to eq(user)
      end
    end

    describe '#is_password?' do
      it 'returns false with wrong password' do
        expect(user.is_password?('abc')).to eq(false)
      end

      it 'returns true with right password' do
        expect(user.is_password?('password')).to eq(true)
      end
    end

    describe '#reset_session_token!' do
      it 'changes old session_token' do
        old_token = user.session_token
        user.reset_session_token!
        expect(user.session_token).to_not eq(old_token)
      end
    end
  end
end
