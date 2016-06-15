feature 'filter tags' do
  scenario 'filters links by tags' do
    visit('/links/new')
    fill_in :title, with: 'hello'
    fill_in :url, with: 'www.hello.com'
    fill_in :tags, with: 'greetings'
    click_button 'Submit'
    visit('/links/new')
    fill_in :title, with: 'bye'
    fill_in :url, with: 'www.bye.com'
    fill_in :tags, with: 'bubbles'
    click_button 'Submit'
    visit('/tags/bubbles')

    within 'ul#links' do
      expect(page).to have_content('bye')
    end
  end
end
