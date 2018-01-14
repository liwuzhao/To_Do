class Session < ApplicationRecord
  SESSION_DURATION = 7.days

  belongs_to :identity

  validates :sid, presence: true, uniqueness: true

  scope :unexpired, -> { where.not(expires_at: nil).where('expires_at > ?', Time.now) }

  before_validation :generate_sid, on: :create
  before_create :set_expires_at

  def user
    self.identity.user
  end

  def token
    AuthToken.encode({ sid: self.sid })
  end

  def mark_as_expired
    self.update_attribute(:expires_at, 1.hour.ago)
  end

  def refresh_expiration
    self.update_attribute(:expires_at, Time.now + SESSION_DURATION)
  end

  def expired?
    self.expires_at.nil? || self.expires_at < Time.now
  end

  def self.mark_all_as_expired
    self.update_all(expires_at: 1.hour.ago)
  end

  private

  def set_expires_at
    self.expires_at = Time.now + SESSION_DURATION
  end

  def generate_sid
    self.sid = SecureRandom.hex(16)
  end
end
