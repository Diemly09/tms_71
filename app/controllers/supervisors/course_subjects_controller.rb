class Supervisors::CourseSubjectsController < ApplicationController
  before_action :find_course_subject, only: [:show]

  def show
    @course_subject = CourseSubject.find_by id: params[:id]
    @tasks = @course_subject.subject.tasks
  end

  private
  def course_subject_params
    params.require(:course_subject).permit :course_id, :subject_id
  end

  def find_course_subject
    @course_subject = CourseSubject.find_by id: params[:id]
    unless @course_subject
      flash[:danger] = t "supervisors.course_subjects.find_subject"
      redirect_to supervisors_courses_path
    end
  end
end
