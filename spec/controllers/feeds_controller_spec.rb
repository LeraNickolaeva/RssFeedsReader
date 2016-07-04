require 'rails_helper'

RSpec.describe FeedsController do

  let(:profile) { create(:profile) }


  describe 'GET #edit' do
    let!(:feed) { create(:feed) }
      specify do
        get :edit, id: feed.id
        expect(response).to render_template :edit
      end
  end



  describe 'GET #show' do
    let!(:feed) { create(:feed) }
    specify do
        get :show, id: feed.id
        expect(response).to render_template :show
    end
  end
end