feature 'add a user' do

  scenario 'new user signs up and sees welcome message' do
    visit('/users/new')
    fill_in(:email, with: "bob@bob.com")
    fill_in(:password, with: "12345" )
    click_button("Sign Up")
    expect(page).to have_content("Welcome, bob@bob.com")
  end

  scenario 'new user signs up and user count increases by 1' do
    visit('/users/new')
    fill_in(:email, with: "bob@bob.com")
    fill_in(:password, with: "12345" )
    click_button("Sign Up")

    expect(User.count).to eq 1
  end

  scenario 'new user signs up and the email address is correct' do
    visit('/users/new')
    fill_in(:email, with: "bob@bob.com")
    fill_in(:password, with: "12345" )
    click_button("Sign Up")

    expect(User.first.email).to eq("bob@bob.com")
  end

end
