class Mission < ApplicationRecord
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
end
