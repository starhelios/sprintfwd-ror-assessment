class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy, :add_to_project, :remove_to_project]

  def index
    @projects = Project.all
  end

  def show
    @members = Member.all - Member.joins(:members_projects)
  end

  def new
    @project = Project.new
  end

  def edit
  end

  def create
    @project = Project.new(project_params)

    if @project.save
      redirect_to @project, notice: 'Project was successfully created.'
    else
      render :new
    end
  end

  def update
    if @project.update(project_params)
      redirect_to @project, notice: 'Project was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @project.destroy
    redirect_to projects_url, notice: 'Project was successfully destroyed.'
  end

  def add_to_project
    @member = Member.find(params[:member_id])
    @project.members << @member
    redirect_to project_path(@project), notice: "#{@member.first_name} was successfully added to project."
  end

  def remove_to_project
    @member_project = @project.members_projects.find_by(member_id:  params[:member_id])
    @member_project.destroy
    redirect_to project_path(@project), notice: "#{@member_project.member.first_name} was successfully removed to project."
  end


  private
    def set_project
      @project = Project.find(params[:id])
    end

    def project_params
      params.require(:project).permit(:name)
    end
end
