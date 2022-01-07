class Subject < ApplicationRecord
    has_many :working_times, dependent: :delete_all
    validates :name, :weekly_hours, :total_hours, presence: true
end
