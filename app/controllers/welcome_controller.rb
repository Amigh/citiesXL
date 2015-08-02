class WelcomeController < ApplicationController
  def index
    @students = Student.limit(3).order('score DESC')
  end
end
