class CreateWorkHistories < ActiveRecord::Migration[7.1]
  def change
    create_table :work_histories do |t|
      t.references :pcp_credential, null: false, foreign_key: true
      t.date   :work_start
      t.date   :work_end
      t.string :employer
      t.string :position

      t.timestamps
    end
  end
end
