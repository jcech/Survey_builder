class Question < ActiveRecord::Base
  belongs_to :survey
  has_many :answers
  has_many :choices, through: :answers

  # def question_total
  #   found_choices = []
  #   self.answers.each do |answer|
  #     answer.choices.each do |choice|
  #       found_choices << choice.answer_id
  #     end
  #   end
  #   found_choices
  # end

  def question_count
    self.answers.each do |answer|
      answer_total = self.choices.count(answer.id)
      percent = (answer_total.to_f / self.question_total.length.to_f) * 100

      puts "#{answer.description} was chosen #{percent}% of the time for a total of #{answer_total}"
    end
  end
end


