require 'spec_helper'
require_relative '../../app/models/rubyfriends_app'

describe RubyfriendsApp do
  let(:app) { described_class.new }

  def make_entry_with_date(date)
    app.new_entry(published_at: DateTime.parse(date), published: true)
  end

  describe '#entries' do
    it 'is sorted in reverse chronological order' do
      oldest = make_entry_with_date("2011-09-09")
      newest = make_entry_with_date("2011-09-11")
      middle = make_entry_with_date("2011-09-10")

      app.add_entry(oldest)
      app.add_entry(newest)
      app.add_entry(middle)

      app.entries.should eq [newest, middle, oldest]
    end
  end

  describe '#paginated_entries' do

    before do
      21.times do |i|
        entry = make_entry_with_date("2011-09-#{i+1}")
        app.add_entry(entry)
      end
    end

    it 'should return 20 entries for page 1' do
      app.paginated_entries(1).count.should be 20
    end

    it 'should return 1 entry for page 2' do
      app.paginated_entries(2).count.should be 1
    end
  end


end