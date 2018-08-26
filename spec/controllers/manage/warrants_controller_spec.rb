# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Manage::WarrantsController, type: :controller do
  it_behaves_like 'a management controller', :show, :warrant
  it_behaves_like 'a management controller', :edit, :warrant
  it_behaves_like 'a management updater', :warrant, { tenure_end: 4.days.ago }, :tenure_end
  it_behaves_like 'a management deleter', :warrant
end
