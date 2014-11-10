class User < ActiveRecord::Base
    before_save { self.email = email.downcase }
    before_create :create_remember_token
    validates :name, presence: true, length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
    has_secure_password
    validates :password, length: { minimum: 3 }

    has_many :events, foreign_key: 'creator_id'
    has_many :attendances, foreign_key: 'attendee_id'
    has_many :attended_events, through: :attendances

    def User.new_remember_token
        SecureRandom.urlsafe_base64
    end

    def User.digest(token)
        Digest::SHA1.hexdigest(token.to_s)
    end

    def show_registered_events(attended_event)
        Attendance.accepted.where(attended_event_id: attended_event)
    end

    private

        def create_remember_token
            self.remember_token = User.digest(User.new_remember_token)
        end
end
