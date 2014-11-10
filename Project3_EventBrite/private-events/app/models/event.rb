class Event < ActiveRecord::Base
    scope :upcoming_events, -> { where "date > ?", Time.zone.now}
    scope :past_events, -> { where "date <= ?", Time.zone.now}
    belongs_to :creator, class_name: 'User'
    has_many :attendances, foreign_key: 'attended_event_id'
    has_many :attendees, through: :attendances

    def pending_requests
        Attendance.pending
    end

    def approved_attendees(event_id)
        Attendance.approved.where(attended_event_id: event_id)
    end

    def attendee_count(event_id)
        Attendance.approved.where(attended_event_id: event_id).count
    end

end
