require 'rails_helper'

RSpec.describe ActivityAtEvent, :type => :model do
  it { is_expected.to belong_to :event }
  it { is_expected.to belong_to :event_activity }
end
