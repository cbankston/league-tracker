require 'rails_helper'

feature 'User sign out' do
  before :each do
    user = FactoryGirl.create(:user)
    login_as user, scope: :user
  end

  scenario 'should sign out the user' do
    visit '/'

    click_link I18n.t('actions.signout')

    expect(page).to have_content I18n.t('devise.sessions.signed_out')
    expect(page).to have_link I18n.t('actions.signin')
    expect(current_path).to eq('/')
  end
end
