class User < ApplicationRecord
  mount_uploader :avatar, AvatarUploader
  has_many :activities, dependent: :destroy
  has_many :user_courses
  has_many :courses, through: :user_courses
  has_many :user_subjects
  has_many :subjects, through: :user_subjects
  has_many :user_tasks
  has_many :tasks, through: :user_tasks

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  before_save :downcase_email

  validates :name, presence: true, length: {maximum: 50}
  validates :email, presence: true, length: {maximum: 255},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: {minimum: 6}, allow_blank: true
  has_secure_password
  
  scope :supervisor, -> {where supervisor: true}
  scope :trainee, -> {where supervisor: false}

  private
  def downcase_email
    self.email.downcase!
  end
  has_secure_password
end
