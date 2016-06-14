require 'spec_helper'

feature 'Creating a link' do

  scenario 'I can create a new link' do
    visit '/links/new'
    fill_in('title', with: 'google')
    fill_in('url', with: 'www.google.com')
    click_button('Create link')

    expect(current_path).to eq '/links'

    within 'ul#links' do
      expect(page).to have_link('google', :href => '//www.google.com')
      # Link.last.destroy
    end
  end

  scenario 'I can create a new link with a tag'do
  visit '/links/new'
  fill_in('title', with: 'google')
  fill_in('url', with: 'www.google.com')
  fill_in('tags', with: 'search engine')
  click_button('Create link')
  link = Link.first
  expect(current_path).to eq '/links'
  expect(link.tags.map(&:name)).to include('search engine')
  end
end
