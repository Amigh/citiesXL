class Project < ActiveRecord::Base
  validates :population, :cash_flow,:income,:money,
            :satis_people_1 ,:satis_people_2 ,:satis_people_3 ,:satis_people_4 ,
            :satis_work_1 ,:satis_work_2 ,:satis_work_3,:satis_work_4,presence: true
  MEDAL_POPULATION_GOLD_LIMIT = 200000
  MEDAL_POPULATION_SILVER_LIMIT = 100000
  MEDAL_POPULATION_BRONZE_LIMIT = 50000

  MEDAL_CASHFLOW_GOLD_LIMIT = 50000
  MEDAL_CASHFLOW_SILVER_LIMIT = 20000
  MEDAL_CASHFLOW_BRONZE_LIMIT = 10000

  MEDAL_INCOME_GOLD_LIMIT = 100000
  MEDAL_INCOME_SILVER_LIMIT = 50000
  MEDAL_INCOME_BRONZE_LIMIT = 20000

  MEDAL_MONEY_GOLD_LIMIT = 10000000
  MEDAL_MONEY_SILVER_LIMIT = 5000000
  MEDAL_MONEY_BRONZE_LIMIT = 2000000

  MEDAL_SAT_PEOPLE_1_GOLD_LIMIT   = 80
  MEDAL_SAT_PEOPLE_1_SILVER_LIMIT = 70
  MEDAL_SAT_PEOPLE_1_BRONZE_LIMIT = 60

  MEDAL_SAT_PEOPLE_2_GOLD_LIMIT   = 80
  MEDAL_SAT_PEOPLE_2_SILVER_LIMIT = 70
  MEDAL_SAT_PEOPLE_2_BRONZE_LIMIT = 60

  MEDAL_SAT_PEOPLE_3_GOLD_LIMIT   = 80
  MEDAL_SAT_PEOPLE_3_SILVER_LIMIT = 70
  MEDAL_SAT_PEOPLE_3_BRONZE_LIMIT = 60

  MEDAL_SAT_PEOPLE_4_GOLD_LIMIT   = 80
  MEDAL_SAT_PEOPLE_4_SILVER_LIMIT = 70
  MEDAL_SAT_PEOPLE_4_BRONZE_LIMIT = 60

  MEDAL_SAT_WORK_1_GOLD_LIMIT   = 90
  MEDAL_SAT_WORK_1_SILVER_LIMIT = 80
  MEDAL_SAT_WORK_1_BRONZE_LIMIT = 70

  MEDAL_SAT_WORK_2_GOLD_LIMIT   = 90
  MEDAL_SAT_WORK_2_SILVER_LIMIT = 80
  MEDAL_SAT_WORK_2_BRONZE_LIMIT = 70

  MEDAL_SAT_WORK_3_GOLD_LIMIT   = 90
  MEDAL_SAT_WORK_3_SILVER_LIMIT = 80
  MEDAL_SAT_WORK_3_BRONZE_LIMIT = 70

  MEDAL_SAT_WORK_4_GOLD_LIMIT   = 90
  MEDAL_SAT_WORK_4_SILVER_LIMIT = 80
  MEDAL_SAT_WORK_4_BRONZE_LIMIT = 70
  #TODO
  MEDAL_SAT_SHOP_GOLD_LIMIT   = 90
  MEDAL_SAT_SHOP_SILVER_LIMIT = 80
  MEDAL_SAT_SHOP_BRONZE_LIMIT = 70

  MEDAL_SAT_SERVICE_GOLD_LIMIT   = 90
  MEDAL_SAT_SERVICE_SILVER_LIMIT = 80
  MEDAL_SAT_SERVICE_BRONZE_LIMIT = 70

  MEDAL_SAT_TRAFIC_GOLD_LIMIT   = 90
  MEDAL_SAT_TRAFIC_SILVER_LIMIT = 80
  MEDAL_SAT_TRAFIC_BRONZE_LIMIT = 70

  MEDAL_SAT_ENV_GOLD_LIMIT   = 80
  MEDAL_SAT_ENV_SILVER_LIMIT = 70
  MEDAL_SAT_ENV_BRONZE_LIMIT = 60

  MEDAL_SAT_FREIGHT_GOLD_LIMIT =   90
  MEDAL_SAT_FREIGHT_SILVER_LIMIT = 80
  MEDAL_SAT_FREIGHT_BRONZE_LIMIT = 70

  belongs_to :student

  def self.import(file)
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    puts header
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      student = Student.find_by(:class_number => row['class_number'], :class_name => row['class_name'],:year =>row['year'])
      project = Project.new
      project.student_id = student.id
      project.attributes = row.to_hash.slice(:population ,:cash_flow,:income)
      project.save!
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


  def add_medal(student,medal)
    if medal
      if Medalization.where(:student_id => student.id,:medal_id => medal.id).blank?
        Medalization.create!(:student_id => student.id, :medal_id => medal.id)
        student.score += medal.score
        student.save!
      end
    end
  end

  def grade()
    @student = Student.find(self.student_id)
    @medal_population_gold  = Medal.find_by(:name =>'population',:type_name =>'gold')
    @medal_population_silver = Medal.find_by(:name =>'population',:type_name =>'silver')
    @medal_population_bronze = Medal.find_by(:name =>'population',:type_name =>'bronze')

    @medal_cashflow_gold   = Medal.find_by(:name =>'cashflow',:type_name =>'gold')
    @medal_cashflow_silver = Medal.find_by(:name =>'cashflow',:type_name =>'silver')
    @medal_cashflow_bronze = Medal.find_by(:name =>'cashflow',:type_name =>'bronze')

    @medal_income_gold   = Medal.find_by(:name =>'income',:type_name =>'gold')
    @medal_income_silver = Medal.find_by(:name =>'income',:type_name =>'silver')
    @medal_income_bronze = Medal.find_by(:name =>'income',:type_name =>'bronze')

    @medal_money_gold   = Medal.find_by(:name =>'money',:type_name =>'gold')
    @medal_money_silver = Medal.find_by(:name =>'money',:type_name =>'silver')
    @medal_money_bronze = Medal.find_by(:name =>'money',:type_name =>'bronze')

    @medal_sat_people_1_gold   = Medal.find_by(:name =>'sat_people_1',:type_name =>'gold')
    @medal_sat_people_1_silver = Medal.find_by(:name =>'sat_people_1',:type_name =>'silver')
    @medal_sat_people_1_bronze = Medal.find_by(:name =>'sat_people_1',:type_name =>'bronze')

    @medal_sat_people_2_gold   = Medal.find_by(:name =>'sat_people_2',:type_name =>'gold')
    @medal_sat_people_2_silver = Medal.find_by(:name =>'sat_people_2',:type_name =>'silver')
    @medal_sat_people_2_bronze = Medal.find_by(:name =>'sat_people_2',:type_name =>'bronze')

    @medal_sat_people_3_gold   = Medal.find_by(:name =>'sat_people_3',:type_name =>'gold')
    @medal_sat_people_3_silver = Medal.find_by(:name =>'sat_people_3',:type_name =>'silver')
    @medal_sat_people_3_bronze = Medal.find_by(:name =>'sat_people_3',:type_name =>'bronze')

    @medal_sat_people_4_gold   = Medal.find_by(:name =>'sat_people_4',:type_name =>'gold')
    @medal_sat_people_4_silver = Medal.find_by(:name =>'sat_people_4',:type_name =>'silver')
    @medal_sat_people_4_bronze = Medal.find_by(:name =>'sat_people_4',:type_name =>'bronze')

    @medal_sat_work_1_gold   = Medal.find_by(:name =>'sat_work_1',:type_name =>'gold')
    @medal_sat_work_1_silver = Medal.find_by(:name =>'sat_work_1',:type_name =>'silver')
    @medal_sat_work_1_bronze = Medal.find_by(:name =>'sat_work_1',:type_name =>'bronze')

    @medal_sat_work_2_gold   = Medal.find_by(:name =>'sat_work_2',:type_name =>'gold')
    @medal_sat_work_2_silver = Medal.find_by(:name =>'sat_work_2',:type_name =>'silver')
    @medal_sat_work_2_bronze = Medal.find_by(:name =>'sat_work_2',:type_name =>'bronze')

    @medal_sat_work_3_gold   = Medal.find_by(:name =>'sat_work_3',:type_name =>'gold')
    @medal_sat_work_3_silver = Medal.find_by(:name =>'sat_work_3',:type_name =>'silver')
    @medal_sat_work_3_bronze = Medal.find_by(:name =>'sat_work_3',:type_name =>'bronze')

    @medal_sat_work_4_gold   = Medal.find_by(:name =>'sat_work_4',:type_name =>'gold')
    @medal_sat_work_4_silver = Medal.find_by(:name =>'sat_work_4',:type_name =>'silver')
    @medal_sat_work_4_bronze = Medal.find_by(:name =>'sat_work_4',:type_name =>'bronze')

    # POPULATION
    if self.population >= MEDAL_POPULATION_GOLD_LIMIT
      puts @medal_population_gold.id
      add_medal(@student,@medal_population_gold)
    end
    if  self.population >= MEDAL_POPULATION_SILVER_LIMIT
      add_medal(@student,@medal_population_silver)
    end
    if self.population >= MEDAL_POPULATION_BRONZE_LIMIT
      add_medal(@student,@medal_population_bronze)
    end
    # CASHFLOW
    if self.cash_flow >= MEDAL_CASHFLOW_GOLD_LIMIT
      add_medal(@student,@medal_cashflow_gold)
    end
    if self.cash_flow >= MEDAL_CASHFLOW_SILVER_LIMIT
      add_medal(@student,@medal_cashflow_silver)
    end
    if self.cash_flow >= MEDAL_CASHFLOW_BRONZE_LIMIT
      add_medal(@student,@medal_cashflow_bronze)
    end
    # INCOME
    if self.income >= MEDAL_INCOME_GOLD_LIMIT
      add_medal(@student,@medal_income_gold)
    end
    if self.income >= MEDAL_INCOME_SILVER_LIMIT
      add_medal(@student,@medal_income_silver)
    end
    if self.income >= MEDAL_INCOME_BRONZE_LIMIT
      add_medal(@student,@medal_income_bronze)
    end
    # MONEY
    if self.money >= MEDAL_MONEY_GOLD_LIMIT
      add_medal(@student,@medal_money_gold)
    end
    if  self.money >= MEDAL_MONEY_SILVER_LIMIT
      add_medal(@student,@medal_money_silver)
    end
    if  self.money >= MEDAL_MONEY_BRONZE_LIMIT
      add_medal(@student,@medal_money_bronze)
    end
    # SATIS_PEOPLE_1
    if self.satis_people_1 >= MEDAL_SAT_PEOPLE_1_GOLD_LIMIT
      add_medal(@student,@medal_sat_people_1_gold)
    end
    if  self.satis_people_1 >= MEDAL_SAT_PEOPLE_1_SILVER_LIMIT
      add_medal(@student,@medal_sat_people_1_silver)
    end
    if self.satis_people_1 >= MEDAL_SAT_PEOPLE_1_BRONZE_LIMIT
      add_medal(@student,@medal_sat_people_1_bronze)
    end
    # SATIS_PEOPLE_2
    if self.satis_people_2 >= MEDAL_SAT_PEOPLE_2_GOLD_LIMIT
      add_medal(@student,@medal_sat_people_2_gold)
    end
    if  self.satis_people_2 >= MEDAL_SAT_PEOPLE_2_SILVER_LIMIT
      add_medal(@student,@medal_sat_people_2_silver)
    end
    if self.satis_people_2 >= MEDAL_SAT_PEOPLE_2_BRONZE_LIMIT
      add_medal(@student,@medal_sat_people_2_bronze)
    end
    # SATIS_PEOPLE_3
    if self.satis_people_3 >= MEDAL_SAT_PEOPLE_3_GOLD_LIMIT
      add_medal(@student,@medal_sat_people_3_gold)
    end
    if self.satis_people_3 >= MEDAL_SAT_PEOPLE_3_SILVER_LIMIT
      add_medal(@student,@medal_sat_people_3_silver)
    end
    if  self.satis_people_3 >= MEDAL_SAT_PEOPLE_3_BRONZE_LIMIT
      add_medal(@student,@medal_sat_people_3_bronze)
    end
    # SATIS_PEOPLE_4
    if self.satis_people_4 >= MEDAL_SAT_PEOPLE_4_GOLD_LIMIT
      add_medal(@student,@medal_sat_people_4_gold)
    end
    if self.satis_people_4 >= MEDAL_SAT_PEOPLE_4_SILVER_LIMIT
      add_medal(@student,@medal_sat_people_4_silver)
    end
    if self.satis_people_4 >= MEDAL_SAT_PEOPLE_4_BRONZE_LIMIT
      add_medal(@student,@medal_sat_people_4_bronze)
    end

    # SATIS_WORK_1
    if self.satis_work_1 >= MEDAL_SAT_WORK_1_GOLD_LIMIT
      add_medal(@student,@medal_sat_work_1_gold)
    end
    if  self.satis_work_1 >= MEDAL_SAT_WORK_1_SILVER_LIMIT
      add_medal(@student,@medal_sat_work_1_silver)
    end
    if self.satis_work_1 >= MEDAL_SAT_WORK_1_BRONZE_LIMIT
      add_medal(@student,@medal_sat_work_1_bronze)
    end
    # SATIS_WORK_2
    if self.satis_work_2 >= MEDAL_SAT_WORK_2_GOLD_LIMIT
      add_medal(@student,@medal_sat_work_2_gold)
    end
    if  self.satis_work_2 >= MEDAL_SAT_WORK_2_SILVER_LIMIT
      add_medal(@student,@medal_sat_work_2_silver)
    end
    if self.satis_work_2 >= MEDAL_SAT_WORK_2_BRONZE_LIMIT
      add_medal(@student,@medal_sat_work_2_bronze)
    end
    # SATIS_WORK_3
    if self.satis_work_3 >= MEDAL_SAT_WORK_3_GOLD_LIMIT
      add_medal(@student,@medal_sat_work_3_gold)
    end
    if self.satis_work_3 >= MEDAL_SAT_WORK_3_SILVER_LIMIT
      add_medal(@student,@medal_sat_work_3_silver)
    end
    if  self.satis_work_3 >= MEDAL_SAT_WORK_3_BRONZE_LIMIT
      add_medal(@student,@medal_sat_work_3_bronze)
    end
    # SATIS_WORK_4
    if self.satis_work_4 >= MEDAL_SAT_WORK_4_GOLD_LIMIT
      add_medal(@student,@medal_sat_work_4_gold)
    end
    if self.satis_work_4 >= MEDAL_SAT_WORK_4_SILVER_LIMIT
      add_medal(@student,@medal_sat_work_4_silver)
    end
    if self.satis_work_4 >= MEDAL_SAT_WORK_4_BRONZE_LIMIT
      add_medal(@student,@medal_sat_work_4_bronze)
    end
  end
end
