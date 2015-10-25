class FixTypoInReigns < ActiveRecord::Migration
  def change
    rename_column :reigns, :runenr_up_consort_persona_id, :runner_up_consort_persona_id
  end
end
