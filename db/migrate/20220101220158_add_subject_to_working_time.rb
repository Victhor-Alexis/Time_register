class AddSubjectToWorkingTime < ActiveRecord::Migration[6.1]
  def change
    add_reference :working_times, :subject, null: false, foreign_key: true
  end
end
