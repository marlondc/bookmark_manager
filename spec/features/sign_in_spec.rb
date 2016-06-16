feature 'sign in' do

  let!(:user) do
    User.create(email: 'alice@example.com',
             password: '12345678',
             password_confirmation: '12345678')
  end

  scenario 'With correct credentials' do
    sign_in(email: user.email, password: user.password)
    expect(page).to have_content("Welcome, #{user.email}")
  end

  def sign_in(email:, password:)
  	visit '/sessions/new'
  	fill_in :email, with: email
  	fill_in :password, with: password
  	click_button 'Sign in'
  end

end
