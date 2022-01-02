class Subject < ApplicationRecord
    has_many :working_times
    validates :name, :weekly_hours, :total_hours, presence: true
end
