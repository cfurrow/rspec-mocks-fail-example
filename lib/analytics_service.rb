require 'tracker'

class AnalyticsService
  class << self
    def track(
      user:,
      event:,
      timestamp:,
      anonymous_id: nil,
      properties: {},
      include_common_properties: true,
      integrations: nil
    )
      properties ||= {}

      payload = {
        user_id: user&.id,
        anonymous_id: anonymous_id,
        event: event,
        properties: include_common_properties ? properties.merge(common_event_properties(user)) : properties,
        timestamp: timestamp
      }

      payload[:integrations] = integrations if integrations

      tracker.track(payload)
    end

    def tracker
      @tracker ||= Tracker.new
    end
   
    private

    def common_event_properties(user)
      return {} if user.nil?
  
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
  end
end
