class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  # after_action only: [:update,:create]
  # GET /projects
  # GET /projects.json
  def index
    @student = Student.find(params[:student_id])
    @projects = @student.projects.all
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
  end

  # GET /projects/new
  def new
    @student = Student.find(params[:student_id])
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
    @student = Student.find(params[:student_id])
  end

  # POST /projects
  # POST /projects.json
  def create
    @student = Student.find(params[:student_id])
    @project = @student.projects.create(project_params)
    @project.student_id = @student.id
    respond_to do |format|
      if @project.save
        @project.grade()
        format.html { redirect_to student_projects_path, notice: 'Project was successfully created.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to student_projects_path, notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to student_projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:population, :cash_flow, :income, :money, :satis_people_1,:satis_people_2,
                                      :satis_people_3,:satis_people_4, :satis_work_1,:satis_work_2,:satis_work_3,:satis_work_4)
    end
end
