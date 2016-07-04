require 'rails_helper'

describe User::UsersController do
  before { sign_in(user) }
  let(:user) { create(:user, email: 'email@example.com') }


  describe 'PATCH #update' do
    before { patch :update, params }

    context 'success' do
      let(:params) do
        {
            user: {
                email:                 'carl_jonson@gmail.com',
                password:              'password',
                password_confirmation: 'password'
            }
        }
      end

      specify do
        expect(user.reload.email).to eq 'carl_jonson@gmail.com'
        expect(response).to redirect_to edit_user_user_path
      end
    end

    context 'failure' do
      let(:params) do
        { user: { email: '', password: '', password_confirmation: '' } }
      end

    end
  end
end