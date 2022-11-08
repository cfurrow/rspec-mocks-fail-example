require 'analytics_service'
require 'date'

RSpec.describe AnalyticsService do
  describe '.track' do
    let(:user) { double('User', id: 1) }
    let(:event) { 'foobar' }
    let(:timestamp) { DateTime.parse('2020-01-01') }
    let(:properties) { { fake_property: 'fake value' } }
    let(:common_event_properties) do
      {
        has_primary: true,
        track_id: 999,
        track_assignment_id: 1234, 
        product_id: 1,
        product_subscription_id: 11, 
        product_subscription_assignment_id: 49494,
        deployment_type: 'standard',
        hubspot_contact_id: 'abc-123'
      }
    end

    it 'does not fail when I use .receive().with()' do
      expect(described_class.tracker).to receive(:track).with(
          user_id: user.id,
          event: event,
          properties: properties.merge(common_event_properties),
          timestamp: timestamp,
          anonymous_id: nil
        )
      described_class.track(user: user, event: event, properties: properties.merge(common_event_properties), timestamp: timestamp)
    end

    it 'does not fail when I use .receive() block-form' do
      expect(described_class.tracker).to receive(:track) do |args|
          expected_args = {
            user_id: user.id,
            event: event,
            properties: properties.merge(common_event_properties),
            timestamp: timestamp,
            anonymous_id: nil
        }

        expect(args).to match(expected_args)
      end
      described_class.track(user: user, event: event, properties: properties.merge(common_event_properties), timestamp: timestamp)
    end
  end
end
