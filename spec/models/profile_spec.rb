require 'rails_helper'

describe Profile do

  it { expect(subject).to belong_to(:user) }
  it { expect(subject).to validate_presence_of(:user_id) }
  it { expect(subject).to validate_presence_of(:nickname) }
  it { expect(subject).to validate_uniqueness_of(:nickname) }

  describe '::by_nickname' do
    let(:profile) { create(:profile, nickname: 'nickname')  }

    specify do
      expect(described_class.by_nickname('nickname')).to eq [profile]
      expect(described_class.by_nickname('nickname1')).to be_empty
    end
  end

  describe '#name' do
    subject { build(:profile, first_name: first_name, last_name: last_name) }

    context 'first name and last name present' do
      let(:first_name) { 'Carl' }
      let(:last_name) { 'Johnson' }

      specify { expect(subject.name).to eq 'Carl Johnson' }
    end

    context 'only first name presents' do
      let(:first_name) { 'Carl' }
      let(:last_name) { '' }

      specify { expect(subject.name).to eq 'Carl' }
    end

    context 'only last name presents' do
      let(:first_name) { '' }
      let(:last_name) { 'Johnson' }

      specify { expect(subject.name).to eq 'Johnson' }
    end

    context 'first name and last name are not present' do
      let(:first_name) { '' }
      let(:last_name) { '' }

      specify { expect(subject.name).to eq '' }
    end
  end

  describe '#full_name' do
    subject { build(:profile, nickname: 'CJ') }

    before do
      allow_any_instance_of(described_class).to receive(:name).and_return(name)
    end

    context 'with name' do
      let(:name) { 'Carl Johnson' }
      specify { expect(subject.full_name).to eq 'CJ [Carl Johnson]' }
    end

    context 'without name' do
      let(:name) { '' }
      specify { expect(subject.full_name).to eq 'CJ' }
    end
  end
end