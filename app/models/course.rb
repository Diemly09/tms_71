class Course < ApplicationRecord
  has_many :course_subjects, inverse_of: :course
  has_many :subjects, through: :course_subjects
  has_many :user_courses, dependent: :destroy, inverse_of: :course
  has_many :users, through: :user_courses

  enum status: {init: 0, started: 1, finished: 2}

  validates :name, presence: true
  validates :description, presence: true, length: {maximum: 140}

  accepts_nested_attributes_for :course_subjects, allow_destroy: true
end
