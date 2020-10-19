require 'spec_helper'

describe Spree::User do
  describe "#referred_by_id_present?" do
    it "returns true if referred_by_id is present" do
      user = Spree::User.new(referred_by_id: 2)
      expect(user.send(:referred_by_id_present?)).to eq(true)
    end

    it "returns false if referred_by_id is not present" do
      user = Spree::User.new
      expect(user.send(:referred_by_id_present?)).to eq(false)
    end
  end

  describe "#referred_by_id" do
    let(:user) { FactoryBot.create(:user) }
    let(:user2) { FactoryBot.create(:user) }

    context 'when user is updated' do
      it 'referred_by_id can not be the same as user id' do
        user.referred_by_id = user.id
        expect(user.save).to eq(false)
        expect(user.errors.details[:referred_by_id].pluck(:error)).to include(:cant_refer_yourself)

        user.referred_by_id = user2.id
        expect(user.save).to eq(true)
        expect(user.errors[:referred_by_id]).to be_empty
      end
    end

    context 'when referred_by_id is present' do
      it 'referrer must exist' do
        user.referred_by_id = user.id + 1
        expect(user.save).to eq(false)
        expect(user.errors.details[:referrer].pluck(:error)).to include(:blank)

        user.referrer = user2
        expect(user.save).to eq(true)
        expect(user.errors[:referrer]).to be_empty
      end
    end
  end
end
