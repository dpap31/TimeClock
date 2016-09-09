require 'spec_helper'

describe '#initialize' do
  context 'IN action' do
    before(:all) do
      params = { action: :in, note: 'note' }
      @tc = TimeClock.new(params)
    end
    it 'has valid action' do
      expect(@tc.instance_variable_get(:@action)).to eq(:in)
    end
    it 'has valid punch class' do
      expect(@tc.instance_variable_get(:@punch).class).to eq(Punches)
    end
  end

  context 'OUT action' do
    before(:all) do
      params = { action: :out, note: 'note' }
      @tc = TimeClock.new(params)
    end
    it 'has valid action' do
      expect(@tc.instance_variable_get(:@action)).to eq(:out)
    end
  end
end

describe '#launch!' do
  context 'IN' do
    it 'displays notification' do
      tc = TimeClock.new(action: :in, note: '')
      expect(tc).to receive(:system).with(" echo \"Clocked in at #{Time.now.strftime('%I:%M %p')}\" ")
      tc.launch!
    end
  end
  context 'OUT' do
    it 'displays notification' do
      tc = TimeClock.new(action: :out, note: '')
      expect(tc).to receive(:system).with(" echo \"Clocked out at #{Time.now.strftime('%I:%M %p')}\" ")
      tc.launch!
    end
  end
  context 'DIVIDER' do
    it 'Adds Divider' do
      tc = TimeClock.new(action: :divider, note: 'New Week')
      expect(tc).to receive(:system).with(" echo \"Added divider\nNote - New Week\" ")
      tc.launch!
    end
  end
  context 'LAST' do
    it 'displays notification' do
      clock_in = TimeClock.new(action: :in, note: '')
      expect(clock_in).to receive(:system).with(" echo \"Clocked in at #{Time.now.strftime('%I:%M %p')}\" ")
      clock_in.launch!
      tc = TimeClock.new(action: :last)
      expect(tc).to receive(:system).with(" echo \"Last punch was at: #{Time.now.strftime('%I:%M %p')}\" ")
      tc.launch!
    end
  end
  context 'OPEN' do
    it 'displays notification' do
      punch = Punches.new(action: :open)
      expect(punch).to receive(:system).with(" open \"#{APP_ROOT}/punches.csv\" ")
      punch.open_csv
    end
  end
end
