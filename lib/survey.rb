class Survey < ActiveRecord::Base
  has_many :questions
  validates :description, uniqueness: true
end
