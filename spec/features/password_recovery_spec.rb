feature 'Resetting Password' do

  before do
    sign_up
    Capybara.reset!
  end

  let(:user) { User.first }

  scenario 'When I forget my password I can see a link to reset' do
    visit '/sessions/new'
    click_link('Forgot Password?')
    expect(page).to have_content('Please enter your email address')
  end

  scenario 'When I enter my email, I am told to check my inbox' do
    recover_password
    expect(page).to have_content('Please check your inbox')
  end

  scenario 'assigned a reset token to the user when they recover' do
    expect{ recover_password }.to change{ User.first.password_token }
  end

  scenario 'it does not allow you to use the token after an hour' do
    recover_password
    Timecop.travel(60*60*60) do
      visit("/users/reset_password?token=#{user.password_token}")
      expect(page).to have_content('Your token is invalid')
    end
  end

  scenario 'it asks you for your new password when your token is valid' do
    recover_password
    visit("/users/reset_password?token=#{user.password_token}")
    expect(page).to have_content('Please enter your new password')
  end

  scenario 'it lets you enter a new password with a valid token' do
    recover_password
    visit("/users/reset_password?token=#{user.password_token}")
    fill_in :password, with: 'newpassword'
    fill_in :password_confirmation, with: 'wrongpassword'
    click_button 'Submit'
    expect(page).to have_content('Password does not match the confirmation')
  end

  scenario 'it immediately resets token upon successful password update' do
   recover_password
   set_password(password: "newpassword", password_confirmation: "newpassword")
   visit("/users/reset_password?token=#{user.password_token}")
   expect(page).to have_content("Your token is invalid")
 end
end

def set_password(password:, password_confirmation:)
   visit("/users/reset_password?token=#{user.password_token}")
   fill_in :password, with: password
   fill_in :password_confirmation, with: password_confirmation
   click_button "Submit"
 end

def recover_password
  visit '/users/recover'
  fill_in :email, with:'alice@example.com'
  click_button 'Submit'
end
