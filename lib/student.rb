require 'sqlite3'

class Student

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]
  attr_accessor  :name, :grade
  attr_reader :id

  def self.db
    SQLite3::Database.new("db/students.db")
  end

  def initialize(name, grade)
    @name = name
    @grade = grade
  end

  def self.create_table
    query = "CREATE TABLE students (id INTEGER PRIMARY KEY,name TEXT, grade TEXT);"
    self.db.execute(query)
  end

  def self.drop_table
    query = "DROP TABLE students"
    self.db.execute(query)
  end

  def save
    first_query = "SELECT COUNT(*) FROM students;"
    @id = self.class.db.execute(first_query).flatten[0] + 1
    second_query = "INSERT INTO students (id, name, grade) VALUES (?,?,?);"
    self.class.db.execute(second_query,self.id,self.name,self.grade)
  end

  def self.create(student)
    new_student = self.new(student[:name],student[:grade])
    new_student.save
    new_student

  end

end
