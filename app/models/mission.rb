class Mission < ApplicationRecord
    validates :name, presence: true
    validates :start_at, presence: true
    validates :status, presence: true
    validates :priority, presence: true
end
