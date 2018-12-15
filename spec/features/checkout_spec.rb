feature 'Checkout' do
  let(:email) { Faker::Internet.email }
  let(:first_name) { Faker::Name.first_name }
  let(:last_name) { Faker::Name.last_name }
  let(:address) { Faker::Address.street_address }
  let(:city) { Faker::Address.city }
  let(:state) { Faker::Address.state }
  let(:zip) { Faker::Address.zip }
  let(:phone) { Faker::PhoneNumber.phone_number }

  scenario 'Guest user completes checkout with one product in cart' do
    visit '/'
    click_link 'Ruby on Rails Tote'
    click_button 'Add To Cart'
    click_button 'Checkout'

    within '#guest_checkout' do
      fill_in 'Email', with: email
      click_button 'Continue'
    end

    fill_in 'First Name', with: first_name
    fill_in 'Last Name', with: last_name
    fill_in 'order_bill_address_attributes_address1', with: address
    fill_in 'City', with: city
    select 'United States of America', from: 'Country'
    select state, from: 'order_bill_address_attributes_state_id'
    fill_in 'Zip', with: zip
    fill_in 'Phone', with: phone
    click_button 'Save and Continue'

    choose 'UPS Ground (USD)'
    click_button 'Save and Continue'

    fill_in 'Card Number', with: '4111 1111 1111 1111'
    fill_in 'Expiration', with: '12/2020'
    fill_in 'Card Code', with: '333'
    click_button 'Save and Continue'

    click_button 'Place Order'

    expect(page).to have_content('Thank you for your business. Please print out a copy of this confirmation page for your records.')
    expect(page).to have_content(first_name)
    expect(page).to have_content(last_name)
    expect(page).to have_content(address)
    expect(page).to have_content(city)
    expect(page).to have_content(zip)
    expect(page).to have_content(phone)
  end
end
