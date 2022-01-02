class WorkingTime < ApplicationRecord
    validates :day, :time_i, :time_e, :subject_id, presence: true

    def right_time_i
        self.time_i.to_s[10..18]
    end

    def right_time_e
        self.time_e.to_s[10..18]
    end
end
