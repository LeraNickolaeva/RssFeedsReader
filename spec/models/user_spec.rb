require 'rails_helper'

describe User do
  it { expect(subject).to have_many(:oauth_accounts).dependent(:destroy) }
  it { expect(subject).to have_one(:profile).dependent(:destroy) }

  describe '::from_omniauth' do
    context 'user presents' do
      let!(:oauth_account) { create(:oauth_account) }
      let(:auth) do
        { 'provider' => oauth_account.provider, 'uid' => oauth_account.uid }
      end

      specify 'without current user' do
        expect(described_class.from_omniauth(auth, nil))
          .to eq oauth_account.user

        expect(described_class.count).to eq 1
      end

      context 'with current user' do
        let(:current_user) { create(:user) }

        specify do
          expect(described_class.from_omniauth(auth, current_user))
            .to eq current_user

          expect(oauth_account.reload.user).to eq current_user
        end
      end
    end

    context 'user is not present' do
      let(:auth) { { 'provider' => 'twitter', 'uid' => 'twitter_uid' } }

      specify 'without current user' do
        described_class.from_omniauth(auth, nil).tap do |user|
          expect(user).to be_persisted
          expect(user.email).to be_blank

          user.oauth_accounts.last.tap do |oauth_account|
            expect(oauth_account.provider).to eq 'twitter'
            expect(oauth_account.uid).to eq 'twitter_uid'
          end
        end
      end

      context 'with current user' do
        let(:current_user) { FactoryGirl.create(:user) }

        specify do
          described_class.from_omniauth(auth, current_user).tap do |user|
            expect(user).to eq current_user

            user.oauth_accounts.last.tap do |oauth_account|
              expect(oauth_account.provider).to eq 'twitter'
              expect(oauth_account.uid).to eq 'twitter_uid'
            end
          end
        end
      end
    end
  end

  describe '#connected_to?' do

    context 'connetced user' do
      subject { FactoryGirl.create(:oauth_account, provider: 'twitter').user }
      specify { expect(subject).to be_connected_to 'twitter' }
    end

    context 'not connected user' do
      subject { FactoryGirl.create(:user) }
      specify { expect(subject).to_not be_connected_to 'twitter' }
    end
  end
end
