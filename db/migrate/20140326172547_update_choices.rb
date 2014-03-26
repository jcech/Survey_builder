class UpdateChoices < ActiveRecord::Migration
  def change
    add_column :answers, :question_id, :int


    rename_column :choices, :question_id, :user_id


    create_table :users do |t|
      t.column :description, :string

      t.timestamps
    end
  end
end
