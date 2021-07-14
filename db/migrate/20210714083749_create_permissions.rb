class CreatePermissions < ActiveRecord::Migration[6.1]
  def change
    create_table :permissions do |t|
      t.string :subject_class
      t.string :action

      t.timestamps
    end
  end
end
