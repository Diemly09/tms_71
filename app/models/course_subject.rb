class CourseSubject < ApplicationRecord
  belongs_to :course 
  belongs_to :subject 	

  has_many :user_subjects, dependent: :destroy
end
