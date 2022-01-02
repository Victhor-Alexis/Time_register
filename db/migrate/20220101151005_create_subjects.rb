class CreateSubjects < ActiveRecord::Migration[6.1]
  def change
    create_table :subjects do |t|
      t.string :name
      t.float :weekly_hours
      t.float :total_hours

      t.timestamps
    end
  end
end
