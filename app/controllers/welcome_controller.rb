class WelcomeController < ApplicationController
  before_action :authenticate_admin! , only: [:upload]
  def index
    @students = Student.limit(3).order('score DESC')
    @background = rand(25).to_s + ".jpg"
  end

  def upload
  end
end
