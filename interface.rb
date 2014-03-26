require 'active_record'

require './lib/survey'
require './lib/choice'
require './lib/question'
require './lib/answer'

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
    puts "Press 'e' to exit the program"

    designer_input = gets.chomp.downcase
    case designer_input
    when 'a'
      add_survey
    when 'l'
      list_surveys
    when 'e'
      exit
    else
      puts "Please enter a valid input!"
      designer_menu
    end
   end
end

def add_survey
  puts "What is the name of your new survey:"
  survey_name = gets.chomp
  new_survey = Survey.create(:description => survey_name)
  add_questions(new_survey)
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
  Survey.all.each { |survey| puts survey.description }
end
main_menu
