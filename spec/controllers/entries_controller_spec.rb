require 'rails_helper'

RSpec.describe EntriesController do

  let(:profile) { create(:profile, feeds: [feed]) }
  let(:feed) { create(:feed) }

  specify 'GET #index' do
    get :index, feed_id: feed.id
    expect(response).to render_template :index
  end
end