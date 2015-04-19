class ChangeScaNumberToStringOnPerson < ActiveRecord::Migration
  def change
    change_column :people, :sca_number, :string
  end
end
