require 'active_record'
require 'rspec'
require 'shoulda-matchers'

require 'survey'
require 'question'
require 'choice'
require 'answer'
require 'user'

database_configurations = YAML::load(File.open('./db/config.yml'))
test_configuration = database_configurations['test']
ActiveRecord::Base.establish_connection(test_configuration)


RSpec.configure do |config|
  config.after(:each) do
    Survey.all.each { |survey| survey.destroy }
    Question.all.each { |question| question.destroy }
    Choice.all.each { |choice| choice.destroy }
    Answer.all.each { |answer| answer.destroy }
    User.all.each { |user| user.destroy }
  end
end
