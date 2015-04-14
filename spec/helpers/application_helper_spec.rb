require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  it 'has necessary macros for Devise' do
    expect(helper.resource_name).to eq :user
    expect(helper.resource_class).to eq User
    expect(helper.resource.class).to eq User
    expect(helper.resource.persisted?).to be_falsey
    expect(helper.devise_mapping).to eq Devise.mappings[:user]
  end
end