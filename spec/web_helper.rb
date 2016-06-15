def signup
	visit('/users/new')
	fill_in :email, with: "bob@bob.com"
	fill_in :password, with: "12345"
	fill_in :password_confirmation, with: "12345"
	click_button("Sign Up")
end
