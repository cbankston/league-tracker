require 'rails_helper'

feature 'User sign in' do
  let(:user) { FactoryGirl.create(:user) }

  scenario 'allows user to sign in' do
    visit '/'

    click_link I18n.t('actions.signin')

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password

    click_button I18n.t('actions.signin')

    expect(page).to have_content I18n.t('devise.sessions.signed_in')
    expect(page).to have_link I18n.t('actions.signout')
    expect(current_path).to eq('/')
  end
end
