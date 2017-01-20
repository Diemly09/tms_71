class UserSubject < ApplicationRecord
  belongs_to :course_subject
  belongs_to :subject
  belongs_to :user
  belongs_to :user_course 

  has_many :user_tasks, dependent: :destroy

  enum status: {init: 0, progress: 1, finished: 2}
end
