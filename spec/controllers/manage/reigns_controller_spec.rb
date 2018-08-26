# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Manage::ReignsController, type: :controller do
  it_behaves_like 'a management controller', :show, :reign
  it_behaves_like 'a management controller', :new, :reign
  it_behaves_like 'a management controller', :edit, :reign
  it_behaves_like 'a management creator', :reign, name: Faker::Name.name
  it_behaves_like 'a management updater', :reign, { coronation_event_id: 42 }, :coronation_event_id
end
