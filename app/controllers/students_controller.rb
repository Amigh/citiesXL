class StudentsController < ApplicationController
  before_action :set_student, only: [:add_medal,:remove_medal,:show, :edit, :update, :destroy]
  before_action :authenticate_admin! , only: [:new,:create,:add_medal,:remove_medal,:edit,:update,:destroy,:import,:export]
  # GET /students
  # GET /students.json
  def index
    @year = sort_year
    @class_name = sort_class
    @students = Student.where(:year=> sort_year , :class_name => sort_class).all
  end

  def export
    Student.export(params[:year])
    send_file "public/student.xls",:filename=> 'student.xls', :type =>  "application/vnd.ms-excel"
  end

  def import
    Student.import(params[:file])
    redirect_to students_path
  end

  def add_medal
    Medalization.create!(:student_id => params[:id], :medal_id => params[:m_id])
    @student.score += Medal.find_by(:id => params[:m_id]).score
    @student.save!
    redirect_to :controller => 'students' , :action => 'show'
  end

  def remove_medal
    Medalization.where(:student_id => params[:id], :medal_id => params[:m_id]).delete_all
    @student.score -= Medal.find_by(:id => params[:m_id]).score
    @student.save!
    redirect_to :controller => 'students' , :action => 'show'
  end
  # GET /students/1
  # GET /students/1.json
  def show
    @medals = @student.medals
    @not_mine_medals = Medal.all - @medals
  end

  # GET /students/new
  def new
    @student = Student.new
  end

  # GET /students/1/edit
  def edit
  end

  # POST /students
  # POST /students.json
  def create
    @student = Student.new(student_params)

    respond_to do |format|
      if @student.save
        format.html { redirect_to @student, notice: 'Student was successfully created.' }
        format.json { render :show, status: :created, location: @student }
      else
        format.html { render :new }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /students/1
  # PATCH/PUT /students/1.json
  def update
    respond_to do |format|
      if @student.update(student_params)
        format.html { redirect_to @student, notice: 'Student was successfully updated.' }
        format.json { render :show, status: :ok, location: @student }
      else
        format.html { render :edit }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /students/1
  # DELETE /students/1.json
  def destroy
    @student.destroy
    respond_to do |format|
      format.html { redirect_to students_url, notice: 'Student was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def sort_year
    params[:year] || "1392-1393"
  end

  def sort_class
    params[:class_name] || "الف"
  end
  # Use callbacks to share common setup or constraints between actions.
  def set_student
    @student = Student.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def student_params
    params.require(:student).permit(:first_name, :last_name, :avatar, :score, :class_name, :class_number,:year)
  end
end
