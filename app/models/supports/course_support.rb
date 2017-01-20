class Supports::CourseSupport
  def initialize args = {}
    @course = args[:course]
  end

  def subjects
    @subjects ||= Subject.all
  end

  def subject_of_course
    @course_subjects ||= @course.course_subjects
  end

  def trainees
    @trainees ||= User.trainee
  end

  def trainee_of_course
    @trainees ||= @course.users.trainee
  end

  def supervisors
    @supervisors ||= User.supervisor
  end

  def supervisor_of_course
    @supervisors ||=  @course.users.supervisor
  end
end
