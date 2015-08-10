class Student < ActiveRecord::Base
  mount_uploader :avatar, AvatarUploader
  has_many :projects
  has_many :medalizations
  has_many :medals , :through => :medalizations
  validates :first_name,:last_name,:class_name,:class_number,:year,presence: true
  after_initialize :init
  def init
    self.score  ||= 0
  end

  def self.import(file)
    Spreadsheet.client_encoding = 'UTF-8'
    tmp = file.tempfile
    # File.open(Rails.root.join('public', 'uploads', file.original_filename), 'wb') do |f|
    #   f.write(file.read)
    # end
    book = Spreadsheet.open tmp.path
    sheet1 = book.worksheet 0
    header = sheet1.row(0)
    sheet1.each 1 do |row|
      class_name = row[0]
      class_number = row[1]
      year = row[2]
      first_name = row[3]
      last_name = row[4]
      score = row[5]
      student = Student.find_by(:class_name => class_name ,:class_number =>class_number,:year =>year) || new
      student.class_name = class_name
      student.class_number = class_number
      student.year = year
      student.first_name = first_name
      student.last_name = last_name
      student.score = 0
      student.save!
    end

    # student.attributes
    FileUtils.rm tmp.path
  end

  def self.export(year)
    ######################################################################################
    # class_name ,class_number , year, first_name, last_name, score #
    ######################################################################################
    Spreadsheet.client_encoding = 'UTF-8'
    book = Spreadsheet::Workbook.new
    sheet = book.create_worksheet(:name => 'students')
    sheet[0,0] ='کلاس'
    sheet[0,1] ='شماره لیست'
    sheet[0,2] ='سال'
    sheet[0,3] ='نام'
    sheet[0,4] ='نام خانوادگی'
    sheet[0,5]='امتیاز'
    year ||= '1392-1393'
    Student.where(:year =>year.to_s)
        .to_a
        .each_with_index do |student,i|
      sheet[i+1,0]=student.class_name
      sheet[i+1,1]=student.class_number
      sheet[i+1,2]=student.year
      sheet[i+1,3]=student.first_name
      sheet[i+1,4]=student.last_name
      sheet[i+1,5]=student.score
    end
    book.write "public/student.xls"
  end
end
