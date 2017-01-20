class Supervisors::UserSubjectsController < ApplicationController
  before_action :logged_in_user, except: [:edit, :destroy]
  
  def show
  end
  
  def update
    @user_subject = UserSubject.find_by id: params[:id]
    if @user_subject.update_attributes user_subject_params
      redirect_to [:supervisors, @user_subject.user_course.course, @user_subject.course_subject]
    else 
      flash[:danger] = t "flash.danger.subject_status"
    end
  end

  private
  def user_subject_params
    params.require(:user_subject).permit :user_id, :user_course_id, :subject_id, :course_subject_id, :status
  end
end
