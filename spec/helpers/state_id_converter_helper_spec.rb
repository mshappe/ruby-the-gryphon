require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the StateIdConverterHelper. For example:
#
# describe StateIdConverterHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe StateIdConverterHelper, :type => :helper do
  it 'converts a numeric id to a state or province' do
    expect(helper.id_to_code 1).to eq 'AZ'
    expect(helper.id_to_code 64).to eq 'YT'
    expect { helper.id_to_code 65 }.to raise_error RangeError
    expect { helper.id_to_code -1 }.to raise_error RangeError
  end
end
