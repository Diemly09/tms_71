class CreateUserSubjects < ActiveRecord::Migration[5.0]
  def change
    create_table :user_subjects do |t|
      t.references :user, foreign_key: true
      t.references :user_course, foreign_key: true
      t.references :course_subject, foreign_key: true
      t.references :subject, foreign_key: true
      t.datetime :start_date
      t.datetime :end_date
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
