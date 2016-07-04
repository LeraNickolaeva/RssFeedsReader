require 'rails_helper'

describe OauthAccount do
  it { expect(subject).to belong_to(:user) }

  it { expect(subject).to validate_presence_of(:user_id) }
  it { expect(subject).to validate_presence_of(:provider) }
  it { expect(subject).to validate_presence_of(:uid) }

  describe '::by_provider' do
    let(:oauth_account1) { create(:oauth_account, provider: 'twitter') }

    specify do
      expect(described_class.by_provider('twitter')).to eq [oauth_account1]

    end
  end
end
