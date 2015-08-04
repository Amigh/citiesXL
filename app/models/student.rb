class Student < ActiveRecord::Base
  mount_uploader :avatar, AvatarUploader
  has_many :projects
  has_many :medalizations
  has_many :medals , :through => :medalizations
  validates :first_name,:last_name,:score,:avatar,:class_name,:class_number,:year,presence: true


  def self.import(file)
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    puts header
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      student = Student.find_by(:class_number => row['class_number'], :class_name => row['class_name']) || new
      student.attributes = row.to_hash
      student.save!
    end
  end


  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
      when '.csv'  then Roo::Csv.new(file.path,    packed: nil,file_warning: :ignore)
      when '.xls'  then Roo::Excel.new(file.path,  packed: nil,file_warning: :ignore)
      when '.xlsx' then Roo::Excelx.new(file.path, packed: nil,file_warning: :ignore)
      else raise "Unknown file type: #{file.original_filename}"
    end
  end

end
