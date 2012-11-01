require 'spec_helper_nulldb'

require "rspec/mocks/standalone"
stub_const("MOUNT_IMAGE_UPLOADER", true)

require_relative '../../app/models/rubyfriends_app'


describe RubyfriendsApp do
  subject(:app) { described_class.new(->{entries}) }
  let(:entries) { [] }


  it 'has no entries' do
    app.entries.should be_empty
  end

  context 'it has the following default attributes' do
    its(:title) { should_not be_nil }
    its(:subtitle) { should_not be_nil }
    its(:default_hashtag) { should_not be_nil }
  end #context

  describe '#new_entry' do
    let(:entry_role_player_dbl) { OpenStruct.new }
    before do
      app.entry_source = ->{ entry_role_player_dbl }
    end

    it 'returns a new object that will play the role of an entry' do
      app.new_entry.should eq entry_role_player_dbl
    end

    it "sets the entry's app reference to itself" do
      app.new_entry.app.should eq app
    end

    it 'accepts attributes on behalf of the entry maker' do
      # TODO - does entry_source beg for another name?
      # entry_maker? entry_role_player_maker? entry_role_player_source?
      entry_source_dbl = double('entry_source')
      app.entry_source = entry_source_dbl

      entry_source_dbl.should_receive(:call)
        .with(foo: 'bar') { entry_role_player_dbl }

      app.new_entry(foo: 'bar')
    end
  end

  describe '#add_entry' do
    it 'adds the entry to the app' do
      entry_dbl = double('entry')
      entry_dbl.should_receive(:save)
      app.add_entry(entry_dbl)
    end
  end

end
