class CreateWorkingTimes < ActiveRecord::Migration[6.1]
  def change
    create_table :working_times do |t|
      t.string :day
      t.time :time_i
      t.time :time_e

      t.timestamps
    end
  end
end
