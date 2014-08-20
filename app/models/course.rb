class Course < ActiveRecord::Base
  validates :department, presence: true
  validates :level, presence: true,
                    numericality: { greater_than: 0, less_than: 2000 }
end