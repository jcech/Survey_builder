class Answer < ActiveRecord::Base
  has_many :choices
  belongs_to :question

  def total
    self.choices.count(self.id)
  end

  def percentage
    puts self.choices.count
    puts self.total
    results = (self.total.to_f / choices.count.to_f) * 100
  end
end
