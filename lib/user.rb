class User < ActiveRecord::Base
  has_many :choices
  has_many :answers, through: :choices
end
