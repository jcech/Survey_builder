require 'active_record'

require './lib/survey'
require './lib/choice'
require './lib/question'
require './lib/answer'
require './lib/user'

database_configurations = YAML::load(File.open('./db/config.yml'))
development_configuration = database_configurations['development']
ActiveRecord::Base.establish_connection(development_configuration)

def main_menu
  puts "Welcome to Super Survey Builder!"
  puts "Press 'd' if you're a Survey Designer"
  puts "Press 't' if you're a Survey Taker"
  puts "Press 'e' to exit"

  main_input = gets.chomp.downcase
  case main_input
  when 'd'
    designer_menu
  when 't'
    taker_menu
  when 'e'
    exit
  else
    puts "Please enter a valid input!"
    main_menu
  end
end


def designer_menu
  choice = nil
  until choice == "e"
    puts "Press 'a' to add a survey"
    puts "Press 'l' to list all your surveys"
    puts "Press 'ql' to list all the answers for a particular question"
    puts "Press 'e' to exit the program"

    designer_input = gets.chomp.downcase
    case designer_input
    when 'a'
      add_survey
    when 'l'
      list_surveys
    when 'ql'
      list_answers_for_question
    when 'e'
      exit
    else
      puts "Please enter a valid input!"
      designer_menu
    end
   end
end

def taker_menu
  puts "Enter your name:"
  user_name = gets.chomp
  new_user = User.create(:description => user_name)
  take_survey(new_user)
end

def take_survey(user)
  list_surveys
  puts "\n"
  puts "Please select the number of the survey you wish to take."
  selected_survey = Survey.all[gets.chomp.to_i - 1]
  selected_survey.questions.each do |question|
    system 'clear'
    puts "#{question.description}"
      question.answers.each do |answer|
        puts "~ #{answer.description}"
      end
      answer = gets.chomp
      found_answer = question.answers.find_by(description: answer)
      Choice.create(:answer_id => found_answer.id, :user_id => user.id)
  end
end



def add_survey
  puts "What is the name of your new survey:"
  survey_name = gets.chomp
  new_survey = Survey.new(:description => survey_name)
  if new_survey.save
    puts "'#{survey_name}' has been added to your Survey List"
    add_questions(new_survey)
  else
    new_survey.errors.full_messages.each { |message| puts message }
    add_survey
  end
end

def add_questions(survey)
  puts "Enter a question for your survey"
  question = gets.chomp
  new_question = Question.create(:description => question, :survey_id => survey.id)
  add_answers(new_question)
  puts "Would you like to add another question? (y/n)"
  case gets.chomp.downcase
  when "y"
    add_questions(survey)
  when 'n'
  else
    puts "Please choose y or n"
    add_questions(survey)
  end
end

def add_answers(question)
  puts "Enter an answer you'd like to add to #{question.description.upcase}"
  answer = gets.chomp
  new_answer = Answer.create(:description => answer, :question_id => question.id)
  puts "Would you like to add another answer to the question? (y/n)"
  case gets.chomp.downcase
  when 'y'
    add_answers(question)
  when 'n'
  else
    puts "Please choose y or n"
    add_answers(question)
  end
end

def list_surveys
  Survey.all.each_with_index { |survey, index| puts "#{index +1}) #{survey.description}" }
end

def list_answers_for_question
  list_surveys
  survey_index = gets.chomp.to_i
  current_survey = Survey.all[survey_index -1]
  current_survey.questions.each_with_index do |question, index|
    puts "#{index +1}) #{question.description}"
  end
  puts "Choose a question to see the user choices"
  question_index = gets.chomp.to_i
  current_question = current_survey.questions[question_index -1]
  puts current_question.description
end

main_menu
