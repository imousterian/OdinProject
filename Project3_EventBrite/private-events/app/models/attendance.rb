class Attendance < ActiveRecord::Base
    belongs_to :attendee, class_name: 'User'
    belongs_to :attended_event, class_name: 'Event'

    scope :approved, -> { where(state: 'approved')}
    scope :pending, ->  { where(state: 'request_sent')}

    def self.join_event(user_id, event_id, state)
        self.create(attendee_id: user_id, attended_event_id: event_id, state: state)
    end

    def approve(attribute, value)
        self.update_attribute(attribute, value)
    end
end
