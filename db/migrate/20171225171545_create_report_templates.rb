class CreateReportTemplates < ActiveRecord::Migration
  def change
    create_table :report_templates do |t|
      t.references :warrant_type, index: true, foreign_key: true
      t.string :title
      t.jsonb :fields

      t.timestamps null: false
    end
  end
end
