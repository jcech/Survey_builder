require 'spec_helper'

describe Answer do
  it { should have_many :choices }
  it { should belong_to :question}

  describe 'total' do
    it 'should return the amount of times the answer has been chosen' do
      test_question = Question.create(:description => "What is your favorite color?")
      test_answer = Answer.create(:description => "Blue", :question_id => test_question.id)
      test_choice = Choice.create(:answer_id => test_answer.id)
      test_choice2 = Choice.create(:answer_id => test_answer.id)
      test_answer.total.should eq 2
    end
  end

  describe 'percentage' do
    it 'should return the percentage of times the answer has been chosen' do
      test_question = Question.create(:description => "What is your favorite color?")
      test_answer = Answer.create(:description => "Blue", :question_id => test_question.id)
      test_choice = Choice.create(:answer_id => test_answer.id)
      test_answer2 = Answer.create(:description => "Red", :question_id => test_question.id)
      test_choice2 = Choice.create(:answer_id => test_answer2.id)
      test_answer.percentage.should eq 50
    end
  end
end
