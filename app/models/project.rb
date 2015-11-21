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

  MEDAL_SAT_FREIGHT_GOLD_LIMIT   = 90
  MEDAL_SAT_FREIGHT_SILVER_LIMIT = 80
  MEDAL_SAT_FREIGHT_BRONZE_LIMIT = 70

  belongs_to :student
  after_initialize :init
  after_create :grade


  #____________________________________________________#
  def init
    self.satis_services ||= 0
    self.satis_trafic ||= 0
    self.satis_env ||= 0
    self.satis_freight ||= 0
    self.satis_shop ||= 0
    self.money ||= 0
    self.cash_flow ||= 0
    self.income ||= 0
    self.population ||= 0
    self.satis_people_1 ||= 0
    self.satis_people_2 ||= 0
    self.satis_people_3 ||= 0
    self.satis_people_4 ||= 0
    self.satis_work_1 ||= 0
    self.satis_work_2 ||= 0
    self.satis_work_3 ||= 0
    self.satis_work_4 ||= 0
  end

  def self.import(file)
    Spreadsheet.client_encoding = 'UTF-8'
    tmp = file.tempfile
    book = Spreadsheet.open tmp.path
    sheet1 = book.worksheet 0
    header = sheet1.row(0)
    sheet1.each 1 do |row|
      student = Student.find_by(:class_name =>row[0] ,:class_number =>row[1],
                                :year =>row[2],:first_name =>row[3],:last_name=>row[4])
      pr = Project.new
      pr.population = row[5]
      pr.money = row[6]
      pr.income = row[7]
      pr.cash_flow = row[8]
      pr.satis_people_1 = row[9]
      pr.satis_people_2 = row[10]
      pr.satis_people_3 = row[11]
      pr.satis_people_4 = row[12]
      pr.satis_work_1 = row[13]
      pr.satis_work_2 = row[14]
      pr.satis_work_3 = row[15]
      pr.satis_work_4 = row[16]
      pr.satis_shop = row[17]
      pr.satis_env = row[18]
      pr.satis_services = row[19]
      pr.satis_trafic = row[20]
      pr.satis_freight = row[21]
      pr.student_id = student.id
      pr.save!
    end
    FileUtils.rm tmp.path
  end

  def self.export(year)
    ######################################################################################
    # class_name ,class_number , year, first_name, last_name,  #
    ######################################################################################
    ######################################################################################
    # population ,money ,income ,cashflow ,satispeople ,satiswork, satisshop ,satisenv, satisservices ,satistrafic,satisfreight
    ######################################################################################
    Spreadsheet.client_encoding = 'UTF-8'
    book = Spreadsheet::Workbook.new
    sheet = book.create_worksheet(:name => 'projects')
    sheet[0,0] ='کلاس'
    sheet[0,1] ='شماره لیست'
    sheet[0,2] ='سال'
    sheet[0,3] ='نام'
    sheet[0,4] ='نام خانوادگی'
    sheet[0,5] ='جمعیت'
    sheet[0,6] ='پول کل'
    sheet[0,7] ='درآمد'
    sheet[0,8] ='درآمدزایی'
    sheet[0,9] ='رضایت مردم نوع ۱ '
    sheet[0,10]='رضایت مردم نوع ۲ '
    sheet[0,11]='رضایت مردم نوع ۳ '
    sheet[0,12]='رضایت مردم نوع ۴ '
    sheet[0,13]='رضایت کار نوع ۱ '
    sheet[0,14]='رضایت کار نوع ۲ '
    sheet[0,15]='رضایت کار نوع ۳ '
    sheet[0,16]='رضایت کار نوع ۴ '
    sheet[0,17]='رضایت تجاری'
    sheet[0,18]='رضایت محیط زیست'
    sheet[0,19]='رضایت خدمات شهری'
    sheet[0,20]='رضایت ترافیک'
    sheet[0,21]='رضایت حمل و نقل'
    students = Student.where(:year =>year.to_s)
    students.each do |student|
      student.projects.each_with_index do |pr,i|
        sheet[i+1,0]=student.class_name
        sheet[i+1,1]=student.class_number
        sheet[i+1,2]=student.year
        sheet[i+1,3]=student.first_name
        sheet[i+1,4]=student.last_name
        sheet[i+1,5] = pr.population
        sheet[i+1,6] = pr.money
        sheet[i+1,7] = pr.income
        sheet[i+1,8] = pr.cash_flow
        sheet[i+1,9] = pr.satis_people_1
        sheet[i+1,10]= pr.satis_people_2
        sheet[i+1,11]= pr.satis_people_3
        sheet[i+1,12]= pr.satis_people_4
        sheet[i+1,13]= pr.satis_work_1
        sheet[i+1,14]= pr.satis_work_2
        sheet[i+1,15]= pr.satis_work_3
        sheet[i+1,16]= pr.satis_work_4
        sheet[i+1,17]= pr.satis_shop
        sheet[i+1,18]= pr.satis_env
        sheet[i+1,19]= pr.satis_services
        sheet[i+1,20]= pr.satis_trafic
        sheet[i+1,21]= pr.satis_freight
      end
    end
    book.write "public/projects.xls"
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

def grade
  @student = Student.find_by(:id => self.student_id)
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

  @medal_sat_shop_gold   = Medal.find_by(:name =>'sat_shop',:type_name =>'gold')
  @medal_sat_shop_silver = Medal.find_by(:name =>'sat_shop',:type_name =>'silver')
  @medal_sat_shop_bronze = Medal.find_by(:name =>'sat_shop',:type_name =>'bronze')

  @medal_sat_env_gold   = Medal.find_by(:name =>'sat_env',:type_name =>'gold')
  @medal_sat_env_silver = Medal.find_by(:name =>'sat_env',:type_name =>'silver')
  @medal_sat_env_bronze = Medal.find_by(:name =>'sat_env',:type_name =>'bronze')

  @medal_sat_services_gold   = Medal.find_by(:name =>'sat_serv',:type_name =>'gold')
  @medal_sat_services_silver = Medal.find_by(:name =>'sat_serv',:type_name =>'silver')
  @medal_sat_services_bronze = Medal.find_by(:name =>'sat_serv',:type_name =>'bronze')

  @medal_sat_trafic_gold   = Medal.find_by(:name =>'sat_trafic',:type_name =>'gold')
  @medal_sat_trafic_silver = Medal.find_by(:name =>'sat_trafic',:type_name =>'silver')
  @medal_sat_trafic_bronze = Medal.find_by(:name =>'sat_trafic',:type_name =>'bronze')

  @medal_sat_freight_gold   = Medal.find_by(:name =>'sat_freight',:type_name =>'gold')
  @medal_sat_freight_silver = Medal.find_by(:name =>'sat_freight',:type_name =>'silver')
  @medal_sat_freight_bronze = Medal.find_by(:name =>'sat_freight',:type_name =>'bronze')

  # POPULATION
  if self.population >= Project::MEDAL_POPULATION_GOLD_LIMIT
    add_medal(@student,@medal_population_gold)
  end
  if  self.population >= Project::MEDAL_POPULATION_SILVER_LIMIT
    add_medal(@student,@medal_population_silver)
  end
  if self.population >= Project::MEDAL_POPULATION_BRONZE_LIMIT
    add_medal(@student,@medal_population_bronze)
  end
  # CASHFLOW
  if self.cash_flow >= Project::MEDAL_CASHFLOW_GOLD_LIMIT
    add_medal(@student,@medal_cashflow_gold)
  end
  if self.cash_flow >= Project::MEDAL_CASHFLOW_SILVER_LIMIT
    add_medal(@student,@medal_cashflow_silver)
  end
  if self.cash_flow >= Project::MEDAL_CASHFLOW_BRONZE_LIMIT
    add_medal(@student,@medal_cashflow_bronze)
  end
  # INCOME
  if self.income >= Project::MEDAL_INCOME_GOLD_LIMIT
    add_medal(@student,@medal_income_gold)
  end
  if self.income >= Project::MEDAL_INCOME_SILVER_LIMIT
    add_medal(@student,@medal_income_silver)
  end
  if self.income >= Project::MEDAL_INCOME_BRONZE_LIMIT
    add_medal(@student,@medal_income_bronze)
  end
  # MONEY
  if self.money >= Project::MEDAL_MONEY_GOLD_LIMIT
    add_medal(@student,@medal_money_gold)
  end
  if  self.money >= Project::MEDAL_MONEY_SILVER_LIMIT
    add_medal(@student,@medal_money_silver)
  end
  if  self.money >= Project::MEDAL_MONEY_BRONZE_LIMIT
    add_medal(@student,@medal_money_bronze)
  end
  # SATIS_PEOPLE_1
  if self.satis_people_1 >= Project::MEDAL_SAT_PEOPLE_1_GOLD_LIMIT
    add_medal(@student,@medal_sat_people_1_gold)
  end
  if  self.satis_people_1 >= Project::MEDAL_SAT_PEOPLE_1_SILVER_LIMIT
    add_medal(@student,@medal_sat_people_1_silver)
  end
  if self.satis_people_1 >= Project::MEDAL_SAT_PEOPLE_1_BRONZE_LIMIT
    add_medal(@student,@medal_sat_people_1_bronze)
  end
  # SATIS_PEOPLE_2
  if self.satis_people_2 >= Project::MEDAL_SAT_PEOPLE_2_GOLD_LIMIT
    add_medal(@student,@medal_sat_people_2_gold)
  end
  if  self.satis_people_2 >= Project::MEDAL_SAT_PEOPLE_2_SILVER_LIMIT
    add_medal(@student,@medal_sat_people_2_silver)
  end
  if self.satis_people_2 >= Project::MEDAL_SAT_PEOPLE_2_BRONZE_LIMIT
    add_medal(@student,@medal_sat_people_2_bronze)
  end
  # SATIS_PEOPLE_3
  if self.satis_people_3 >= Project::MEDAL_SAT_PEOPLE_3_GOLD_LIMIT
    add_medal(@student,@medal_sat_people_3_gold)
  end
  if self.satis_people_3 >= Project::MEDAL_SAT_PEOPLE_3_SILVER_LIMIT
    add_medal(@student,@medal_sat_people_3_silver)
  end
  if  self.satis_people_3 >= Project::MEDAL_SAT_PEOPLE_3_BRONZE_LIMIT
    add_medal(@student,@medal_sat_people_3_bronze)
  end
  # SATIS_PEOPLE_4
  if self.satis_people_4 >= Project::MEDAL_SAT_PEOPLE_4_GOLD_LIMIT
    add_medal(@student,@medal_sat_people_4_gold)
  end
  if self.satis_people_4 >= Project::MEDAL_SAT_PEOPLE_4_SILVER_LIMIT
    add_medal(@student,@medal_sat_people_4_silver)
  end
  if self.satis_people_4 >= Project::MEDAL_SAT_PEOPLE_4_BRONZE_LIMIT
    add_medal(@student,@medal_sat_people_4_bronze)
  end

  # SATIS_WORK_1
  if self.satis_work_1 >= Project::MEDAL_SAT_WORK_1_GOLD_LIMIT
    add_medal(@student,@medal_sat_work_1_gold)
  end
  if  self.satis_work_1 >= Project::MEDAL_SAT_WORK_1_SILVER_LIMIT
    add_medal(@student,@medal_sat_work_1_silver)
  end
  if self.satis_work_1 >= Project::MEDAL_SAT_WORK_1_BRONZE_LIMIT
    add_medal(@student,@medal_sat_work_1_bronze)
  end
  # SATIS_WORK_2
  if self.satis_work_2 >= Project::MEDAL_SAT_WORK_2_GOLD_LIMIT
    add_medal(@student,@medal_sat_work_2_gold)
  end
  if  self.satis_work_2 >= Project::MEDAL_SAT_WORK_2_SILVER_LIMIT
    add_medal(@student,@medal_sat_work_2_silver)
  end
  if self.satis_work_2 >= Project::MEDAL_SAT_WORK_2_BRONZE_LIMIT
    add_medal(@student,@medal_sat_work_2_bronze)
  end
  # SATIS_WORK_3
  if self.satis_work_3 >= Project::MEDAL_SAT_WORK_3_GOLD_LIMIT
    add_medal(@student,@medal_sat_work_3_gold)
  end
  if self.satis_work_3 >= Project::MEDAL_SAT_WORK_3_SILVER_LIMIT
    add_medal(@student,@medal_sat_work_3_silver)
  end
  if  self.satis_work_3 >= Project::MEDAL_SAT_WORK_3_BRONZE_LIMIT
    add_medal(@student,@medal_sat_work_3_bronze)
  end
  # SATIS_WORK_4
  if self.satis_work_4 >= Project::MEDAL_SAT_WORK_4_GOLD_LIMIT
    add_medal(@student,@medal_sat_work_4_gold)
  end
  if self.satis_work_4 >= Project::MEDAL_SAT_WORK_4_SILVER_LIMIT
    add_medal(@student,@medal_sat_work_4_silver)
  end
  if self.satis_work_4 >= Project::MEDAL_SAT_WORK_4_BRONZE_LIMIT
    add_medal(@student,@medal_sat_work_4_bronze)
  end

  # SATIS_SHOP
  if self.satis_shop >= Project::MEDAL_SAT_SHOP_GOLD_LIMIT
    add_medal(@student,@medal_sat_shop_gold)
  end
  if self.satis_shop >= Project::MEDAL_SAT_SHOP_SILVER_LIMIT
    add_medal(@student,@medal_sat_shop_silver)
  end
  if self.satis_shop >= Project::MEDAL_SAT_SHOP_BRONZE_LIMIT
    add_medal(@student,@medal_sat_shop_bronze)
  end

  # SATIS_ENV
  if self.satis_env >= Project::MEDAL_SAT_ENV_GOLD_LIMIT
    add_medal(@student,@medal_sat_env_gold)
  end
  if self.satis_env >= Project::MEDAL_SAT_ENV_SILVER_LIMIT
    add_medal(@student,@medal_sat_env_silver)
  end
  if self.satis_env >= Project::MEDAL_SAT_ENV_BRONZE_LIMIT
    add_medal(@student,@medal_sat_env_bronze)
  end

  # SATIS_SERVICE
  if self.satis_services >= Project::MEDAL_SAT_SERVICE_GOLD_LIMIT
    add_medal(@student,@medal_sat_services_gold)
  end
  if self.satis_services >= Project::MEDAL_SAT_SERVICE_SILVER_LIMIT
    add_medal(@student,@medal_sat_services_silver)
  end
  if self.satis_services >= Project::MEDAL_SAT_SERVICE_BRONZE_LIMIT
    add_medal(@student,@medal_sat_services_bronze)
  end


  # SATIS_FREIGHT
  if self.satis_freight >= Project::MEDAL_SAT_FREIGHT_GOLD_LIMIT
    add_medal(@student,@medal_sat_freight_gold)
  end
  if self.satis_freight >= Project::MEDAL_SAT_FREIGHT_SILVER_LIMIT
    add_medal(@student,@medal_sat_freight_silver)
  end
  if self.satis_freight >= Project::MEDAL_SAT_FREIGHT_BRONZE_LIMIT
    add_medal(@student,@medal_sat_freight_bronze)
  end


  # SATIS_TRAFIC
  if self.satis_trafic >= Project::MEDAL_SAT_TRAFIC_GOLD_LIMIT
    add_medal(@student,@medal_sat_trafic_gold)
  end
  if self.satis_trafic >= Project::MEDAL_SAT_TRAFIC_SILVER_LIMIT
    add_medal(@student,@medal_sat_trafic_silver)
  end
  if self.satis_trafic >= Project::MEDAL_SAT_TRAFIC_BRONZE_LIMIT
    add_medal(@student,@medal_sat_trafic_bronze)
  end


end
