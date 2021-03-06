class CreateNoteComments < ActiveRecord::Migration[5.0]
  def change
    create_table :note_comments do |t|
      t.text :comment
      t.string :user_name
      t.references :note, index:true, foreign_key:true

      t.timestamps null: false
    end
  end
end
