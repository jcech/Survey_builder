class Answer < ActiveRecord::Base
  has_many :choices
  belongs_to :question
end
