class Admin::SubjectsController < ApplicationController
  before_action :require_login
  before_action :require_admin
  layout "admin"

  def index
    @subjects = Subject.all
  end

  def new
    @subject = Subject.new
  end

  def create
    @subject = Subject.new(subject_params)

    if @subject.save
      redirect_to admin_subjects_path
    else
      render :new
    end
  end

  private
  def subject_params
    params.require(:subject).permit(:title, :description)
  end
end
