class WelcomeController < ApplicationController
  before_action :authenticate_admin! , only: [:upload]
  def index
    @studentsA = Student.where(:class_name => 'الف').limit(3).order('score DESC')
    @studentsB = Student.where(:class_name => 'ب').limit(3).order('score DESC')
    @name = '0'
    while @name == '0'
    	@name = rand(25).to_s
    end
    @background =  @name + ".jpg"
  end

  def upload
  end
end
