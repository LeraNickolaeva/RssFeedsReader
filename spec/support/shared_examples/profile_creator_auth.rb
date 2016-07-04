shared_examples 'ProfileCreator::Auth' do
  subject { described_class.new(user, auth) }
  let(:user) { create(:user) }

  describe '#perform' do
    let(:auth) { { info: { nickname: 'nickname' } } }

    specify 'without profile with such nickname' do
      subject.perform
      expect(user.profile.nickname).to eq 'nickname'
    end

    context 'with profile with such nickname' do
      let!(:profile) { create(:profile, nickname: 'nickname') }
      let!(:profile1) { create(:profile, nickname: 'nickname-1') }
      let!(:profile2) { create(:profile, nickname: 'nickname-2') }

      specify do
        subject.perform
        expect(user.profile.nickname).to eq 'nickname-3'
      end
    end
  end
end
