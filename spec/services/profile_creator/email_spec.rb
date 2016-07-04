require 'rails_helper'

describe ProfileCreator::Email do
  subject { described_class.new(user) }
  let(:user) { create(:user, email: 'user@example.com') }

  describe '#perform' do
    specify 'without profile with such nickname' do
      subject.perform
      expect(user.profile.nickname).to eq 'user'
    end

    context 'with profile with such nickname' do
      let!(:profile) { create(:profile, nickname: 'user') }
      let!(:profile1) { create(:profile, nickname: 'user-1') }
      let!(:profile2) { create(:profile, nickname: 'user-2') }

      specify do
        subject.perform
        expect(user.profile.nickname).to eq 'user-3'
      end
    end
  end
end
