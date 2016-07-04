require 'rails_helper'

describe Feed do
  it { expect(subject).to have_many(:entries).dependent(:destroy) }
  it { expect(subject).to validate_uniqueness_of(:url) }
end
