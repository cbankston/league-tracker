require 'rails_helper'

feature 'Summoner Tracker', :vcr do
  let(:another_user) { FactoryGirl.create(:user) }
  let(:na_summoner) { { region: I18n.t('region.na'), name: 'zomgHazerd' } }
  let(:user) { FactoryGirl.create(:user) }

  before(:each) do
    login_as user, scope: :user

    visit '/'
    click_link I18n.t('summoner_tracker.navigation')

    expect(page).to_not have_content na_summoner[:name]

    click_link I18n.t('summoner_tracker.actions.add_summoner')

    fill_form_and_submit(:summoner_tracker_form, :new, na_summoner)
  end

  scenario 'A user can add a summoner to the tracker' do
    expect(current_path).to eq(summoner_tracker_index_path)
    expect(page).to have_content I18n.t('summoner_tracker.flash.added_success')
    expect(page).to have_content na_summoner[:name]
  end

  scenario 'A user will not see a summoner added to the tracker by another user' do
    expect(page).to have_content na_summoner[:name]

    login_as another_user, scope: :user
    visit summoner_tracker_index_path

    expect(page).to_not have_content na_summoner[:name]
  end
end
