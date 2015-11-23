module StudentsHelper
  def csscolor(student)
    if student.score < 100
      return 'red'
    elsif student.score <300
      return 'orange'
    elsif student.score< 500
      return 'yellow'
    elsif student.score<800
      return 'olive'
    else
      return 'green'
    end
  end
end
