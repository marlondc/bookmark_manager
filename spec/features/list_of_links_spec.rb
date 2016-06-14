require 'spec_helper'

feature 'List of links on homepage' do
  scenario 'See list of links' do
    Link.create(title: "google", url: "www.google.com")
    visit('/')
    within 'ul#links' do
      expect(page).to have_link('google', :href => 'www.google.com')
    end
  end
end
