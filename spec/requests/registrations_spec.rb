require 'spec_helper'

describe "Registrations" do

  subject { page }

  describe 'home_page' do 
    before { visit root_path }

    it { should have_content("Register") }
    it { should have_content("Sign in") }
    it { should have_content("Help") }
  end

  describe 'registration' do
    it 'should send a valid confirmation email' do
      user_email = 'user@example.com'
      ActionMailer::Base.deliveries.clear

      visit new_user_registration_path
      fill_in "Email", with: user_email
      click_button 'Sign up'
      page.should have_content "Welcome"

      confirmation_email = ActionMailer::Base.deliveries.last
      confirmation_email.to.should == [user_email]

      confirmation_token = User.last.confirmation_token
      confirmation_email.body.should match(/#{confirmation_token}/)

      User.last.confirmed?.should be_false

      visit "/users/confirmation?confirmation_token=#{confirmation_token}"
      page.should have_content "Account activation"

      fill_in "Choose a password:", with: 'password'
      fill_in "Password confirmation:", with: 'password'
      select 'Pretoria', :from => 'Time zone'
      click_button 'Activate'

      User.last.should be_confirmed
      User.last.time_zone.should == 'Pretoria'
    end
  end
end
