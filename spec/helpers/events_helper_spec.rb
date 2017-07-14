require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the EventsHelper. For example:
#
# describe EventsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe EventsHelper, :type => :helper do
  let(:event) { create :event }

  describe '#sca_year(date)' do
    describe '30 April 2015' do
      it 'should be 49' do
        expect(helper.sca_year('30 April 2015')).to eq 49
      end
    end

    describe '1 May 2015' do
      it 'should be 50' do
        expect(helper.sca_year('1 May 2015')).to eq 50
      end
    end
  end

  describe '#sca_date(datetime)' do
    describe '30 April 2015' do
      it 'should be 30 April 49 (2015 CE)' do
        expect(helper.sca_date('30 April 2015 8:00 pm')).to eq '30 April 49 (2015&nbsp;CE)  8:00 pm'
      end
    end

    describe '1 May 2015' do
      it 'should be 1 May 50 (2015 CE)' do
        expect(helper.sca_date('1 May 2015 8:00 pm')).to eq ' 1 May 50 (2015&nbsp;CE)  8:00 pm'
      end
    end
  end

  describe '#sca_date(datetime, format: :date_only_no_ce)' do
    it 'should be 1 May 50' do
      expect(helper.sca_date('1 May 2015 8:00 am', format: :date_only_no_ce)).to eq ' 1 May 50'
    end
  end

  describe '#event_date(format: :date_only)' do
    describe 'for a one-day event' do
      it 'returns a single day and not a range' do
        event.start_at = '2015-05-04 8:00:00'
        event.end_at = '2015-05-04 20:00:00'

        expect(helper.event_date(event, format: :date_only)).to eq sca_date('2015-05-04', format: :date_only)
      end
    end

    describe 'for a multi-day event' do
      it 'returns a range, date only' do
        event.start_at = '2015-05-04 8:00:00'
        event.end_at = event.start_at + 48.hours

        expect(helper.event_date(event, format: :date_only)).to eq sca_date(event.start_at.to_s, format: :date_only) +
                                                                       raw('&ndash;') +
                                                                       sca_date(event.end_at.to_s, format: :date_only)
      end
    end
  end

  describe '#event_date(format: :default)' do
    describe 'for a one-day event' do
      it 'returns a date range with beginning and end time' do
        event.start_at = '2015-05-04 8:00:00 am'.to_datetime
        event.end_at = event.start_at + 48.hours

        expect(helper.event_date(event)).to eq sca_date(event.start_at.to_s) +
                                                   raw('&ndash;') +
                                                   sca_date(event.end_at.to_s)
      end
    end
  end
end
