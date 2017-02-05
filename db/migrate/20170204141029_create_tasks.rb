class CreateTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :tasks do |t|
      t.string :title
      t.boolean :done
      t.timestamp :done_at
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
  end
end
