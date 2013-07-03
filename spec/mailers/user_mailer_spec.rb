require 'spec_helper'

describe UserMailer do
  let(:user) { mock_model(User, email: 'user@example.com') }
  let(:event) { Event.new(name: 'event_name', details: 'event_details', date: Date.parse('2020-04-02')) }
  let(:mail) { UserMailer.event_notification(user, event).deliver }

  shared_examples_for "event notifiers" do
    it 'renders the receivers email' do
      mail.to == user.email
    end

    it 'renders the senders email' do
      mail.from == 'remind_me@example.com'
    end

    it 'renders the details' do
      mail.body =~ /#{event.details}/
    end
  end

  describe 'event_notification' do
    it 'renders the subject' do
      mail.subject == "REMINDER: #{mail.subject}"
    end

    it_behaves_like "event notifiers"
  end

  describe 'event_reminder' do
    it 'renders the subject' do
      mail.subject == "3 DAY REMINDER: #{mail.subject}"
    end

    it_behaves_like "event notifiers"
  end
end
