class CreateSurveys < ActiveRecord::Migration
  def change
    create_table :surveys do |t|
      t.column :description, :string

      t.timestamps
    end
    create_table :questions do |t|
      t.column :description, :string
      t.column :survey_id, :int

      t.timestamps
    end
    create_table :choices do |t|
      t.column :question_id, :int
      t.column :answer_id, :int

      t.timestamps
    end
    create_table :answers do |t|
      t.column :description, :string

      t.timestamps
    end
  end
end
