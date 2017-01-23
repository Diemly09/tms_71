class Supervisors::SubjectsController < ApplicationController
  before_action :logged_in_user, :verify_supervisor
  before_action :find_subject, except: [:index, :new, :create]

  def index
    @subjects = Subject.order(created_at: :desc).
      paginate page: params[:page], per_page: Settings.per_page
  end

  def new
    @subject = Subject.new
    Settings.task.times{@subject.tasks.build}
  end

  def create
    @subject = Subject.new subject_params
    if @subject.save
      flash[:info] = t "flash.success.create_subject"
      redirect_to supervisors_subjects_path
    else
      render :new
    end
  end

  def show
    @tasks = @subject.tasks
  end

  def edit
  end

  def update 
    if @subject.update_attributes subject_params
    else
      flash[:danger] = t "flash.danger.subject_update"
    end
    redirect_to supervisors_subject_path @subject 
  end

  def destroy
    @subject.destroy
    flash[:success] = t "flash.delete.delete_subject"
    redirect_to supervisors_subjects_path
  end

  private
  def subject_params
    params.require(:subject).permit :name, :description, :status,
      tasks_attributes: [:id, :name, :description, :_destroy]
  end

  def find_subject
    @subject = Subject.find_by id: params[:id]
    unless @subject
      flash[:danger] = t "flash.existed_subject"
      redirect_to supervisors_subjects_path
    end
  end
end
