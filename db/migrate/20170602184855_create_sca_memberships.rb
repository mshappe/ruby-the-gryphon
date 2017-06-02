class CreateScaMemberships < ActiveRecord::Migration
  def change
    create_table :sca_memberships, id: false do |t|
      t.string :sca_number, index: true, unique: true
      t.datetime :sca_exp_date
    end
  end
end
