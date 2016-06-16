require 'web_helper'


feature 'add a user' do

  scenario 'new user signs up and sees welcome message' do
    signup
    expect(page).to have_content("Welcome, bob@bob.com")
  end

  scenario 'new user signs up and user count increases by 1' do
    signup
    expect(User.count).to eq 1
  end

  scenario 'new user signs up and the email address is correct' do
    signup
    expect(User.first.email).to eq("bob@bob.com")
  end

  scenario 'requires a matching confirmation password' do
   expect { sign_up(password_confirmation: 'wrong') }.not_to change(User, :count)
   expect(current_path).to eq('/users')
   expect(page).to have_content('Password and confirmation do not match')
  end

  scenario 'I cannot sign up without an email address' do
   expect { sign_up(email: nil) }.not_to change(User, :count)
  end

  scenario 'I cannot sign up without a valid email address' do
   expect { sign_up(email: '1234') }.not_to change(User, :count)
  end



  def sign_up(email: 'alice@example.com',
           password: '12345678',
           password_confirmation: '12345678')
    visit '/users/new'
    fill_in :email, with: email
    fill_in :password, with: password
    fill_in :password_confirmation, with: password_confirmation
    click_button 'Sign Up'
 end
end
