# require 'spec_helper'

feature 'filtering by tag' do

  scenario 'filters links with "bubble" tag' do

    visit('/links/new')
    fill_in('title', with: 'test')
    fill_in('url', with: 'www.test.com')
    fill_in('tags', with: 'bubble')
    click_button('Create link')

    visit('/tags/bubble')
    expect(page).to have_link('test', :href => 'http://www.test.com')
  end


end
