# frozen_string_literal: true

class SeedPersonaTypes < ActiveRecord::Migration
  def up
    # Seed the types from the old values so that we can convert easily.
    PersonaType.create!([
                          { id: 90, name: 'Alternate Name' },
                          { id: 91, name: 'Nickname' },
                          { id: 92, name: 'Previous Name' },
                          { id: 93, name: 'Primary Name' },
                          { id: 95, name: 'Merged Name' }
                        ])
  end

  def down; end
end
