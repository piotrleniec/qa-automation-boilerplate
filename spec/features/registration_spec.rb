feature 'Registration' do
  let(:email) { Faker::Internet.email }
  let(:password) { 'spree123' }

  scenario 'User can register' do
    visit '/signup'
    fill_in 'Email', with: email
    fill_in 'Password', with: password
    fill_in 'Password Confirmation', with: password
    click_button 'Create'

    click_link 'My Account'
    expect(page).to have_content email
  end
end
