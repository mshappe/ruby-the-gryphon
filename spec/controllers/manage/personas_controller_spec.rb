require 'rails_helper'

RSpec.describe Manage::PersonasController, type: :controller do
  it_behaves_like 'a management controller', :show, :persona
  it_behaves_like 'a management controller', :edit, :persona
  it_behaves_like 'a management updater', :persona, { name: 'Wombat'}, :name
  it_behaves_like 'a management deleter', :persona
end
