class Mission < ApplicationRecord
    belongs_to :user, counter_cache: true
    include AASM
    validates :name, presence: true
    validates :start_at, presence: true
    validates :end_at, presence: true
    validates :status, presence: true
    validates :priority, presence: true

    validate :end_at_after_start_at?, if: Proc.new{|mission| mission.start_at.present? && mission.end_at.present?}
    def end_at_after_start_at?
        if end_at < start_at
            errors.add :end_at, :after_start_at
        end
    end
    enum status: {
        pending: 0,
        working: 1,
        finished: 2
    }
    enum priority: {
        low: 0,
        medium: 1,
        high: 2
    }
    aasm column: :status do 
        state :pending, initial: true
        state :working
        state :finished

        event :start do 
            transitions from: [:pending], to: :working
        end
        event :finish do
            transitions from: [:pending, :working], to: :finished
        end
    end
end
