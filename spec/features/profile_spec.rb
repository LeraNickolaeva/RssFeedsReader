require 'rails_helper'

describe Profile do
  let(:user) { create(:user) }
  before { login_as(user) }

  specify 'edit' do
    visit edit_user_profile_path

    fill_in 'First name', with: 'Carl'
    fill_in 'Last name',  with: 'Johnson'
    fill_in 'Nickname',   with: 'CJ'
    click_on 'Update'
  end
end
