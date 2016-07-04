require 'rails_helper'

describe User::ProfilesController do
  before { sign_in(user) }
  let(:user) { create(:user) }

  specify 'GET #edit' do
    get :edit
    expect(response).to render_template :edit
  end

  describe 'PATCH #update' do
    let(:params) do
      {
          profile: {
              first_name: 'FirstName',
              last_name:  'LastName',
              nickname:   'Nickname',
              avatar:     uploaded_file('default.png')
          }
      }
    end

    after do
      expect(response).to redirect_to edit_user_profile_path

      user.profile.reload.tap do |profile|
        expect(profile.first_name).to eq 'FirstName'
        expect(profile.last_name).to eq 'LastName'
        expect(profile.nickname).to eq 'Nickname'
        expect(profile.avatar?).to eq true
      end
    end

    specify 'without profile' do
      expect { patch :update, params }.to change(Profile, :count).by(1)
    end

    context 'with profile' do
      let!(:profile) { create(:profile, user: user) }

      specify do
        expect { patch :update, params }.to_not change(Profile, :count)
      end
    end
  end
end