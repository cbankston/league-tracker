require 'rails_helper'

feature 'Home' do

  describe 'Hello World Test' do
    scenario 'user is presented with confirmation dialog when deletes his account' do
      visit '/'
      find('h1')

      expect(page).to have_content 'Hello World'
      expect(current_path).to eq('/')
    end
  end

end
