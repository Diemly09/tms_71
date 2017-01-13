class Supervisors::CoursesController < ApplicationController
  before_action :logged_in_user, except: [:edit, :destroy]
  before_action :verify_supervisor
  before_action :find_course, except: [:new, :create, :index]
  before_action :load_supports, except: [:index, :destroy]

  def index
    @courses = Course.order(created_at: :desc).
      paginate page: params[:page], per_page: Settings.per_page
  end
  
  def new
    @course = Course.new
  end

  def create
    @course = Course.new course_params
    if @course.save
      flash[:info] = t "flash.success.create_course"
      redirect_to supervisors_courses_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @course.update_attributes course_params
      redirect_to supervisors_course_path @course
    else
      render :edit
    end
  end

  def destroy
    @course.destroy
    flash[:success] = t"flash.delete.delete_course"
    redirect_to supervisors_courses_path
  end

  private
  def course_params
    params.require(:course).permit :name, :description, :start_date,
      :end_date, :status, subject_ids: [], user_ids: []
  end

  def find_course
    @course = Course.find_by id: params[:id]
    unless @course
      flash[:danger] = t "flash.danger.course_not_found"
      redirect_to supervisors_courses_path
    end
  end

  def load_supports
    @supports = Supports::CourseSupport.new course: @course
  end
end
