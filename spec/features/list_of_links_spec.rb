require 'spec_helper'

feature 'List of links on homepage' do


  scenario 'See list of links' do
  	testlink = Link.create(title: "google", url: "www.google.com")
    visit('/links')
    within 'ul#links' do
      expect(page).to have_link('google', :href => '//www.google.com')
      # testlink.destroy
    end
  end


end
