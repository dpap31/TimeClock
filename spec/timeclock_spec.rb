require 'spec_helper'

describe '#initialize' do
  context 'IN action' do
    before(:all) do
      params = { action: 'in', note: 'note' }
      @tc = TimeClock.new(params)
    end
    it 'has valid action' do
      expect(@tc.instance_variable_get(:@action)).to eq(:in)
    end
    it 'has valid note' do
      expect(@tc.instance_variable_get(:@note)).to eq('note')
    end
    it 'has valid notification text' do
      expect(@tc.instance_variable_get(:@notification)).to include('Clocked in')
    end
  end
  context 'OUT action' do
    before(:all) do
      params = { action: 'out', note: 'note' }
      @tc = TimeClock.new(params)
    end
    it 'has valid action' do
      expect(@tc.instance_variable_get(:@action)).to eq(:out)
    end
    it 'has valid notification text' do
      expect(@tc.instance_variable_get(:@notification)).to include('Clocked out')
    end
  end
  context 'INVALID action' do
    before(:all) do
      params = { action: 'foo', note: 'note' }
      @tc = TimeClock.new(params)
    end
    it 'has valid action' do
      expect(@tc.instance_variable_get(:@action)).to eq(:invalid)
    end
  end
end

describe '#launch!' do
  context 'IN' do
    it 'displays notification' do
      tc = TimeClock.new(action: 'in')
      expect(tc).to receive(:system).with(" echo \"Clocked in at #{Time.now.strftime('%I:%M %p')}\" ")
      tc.launch!
    end
  end
  context 'OUT' do
    it 'displays notification' do
      tc = TimeClock.new(action: 'out')
      expect(tc).to receive(:system).with(" echo \"Clocked out at #{Time.now.strftime('%I:%M %p')}\" ")
      tc.launch!
    end
  end
  context 'LAST' do
    it 'displays notification' do
      clock_in = TimeClock.new(action: 'in')
      expect(clock_in).to receive(:system).with(" echo \"Clocked in at #{Time.now.strftime('%I:%M %p')}\" ")
      clock_in.launch!
      tc = TimeClock.new(action: 'last')
      expect(tc).to receive(:system).with(" echo \"Last punch was at: #{Time.now.strftime('%I:%M %p')}\" ")
      tc.launch!
    end
  end
  context 'OPEN' do
    it 'displays notification' do
      punch = Punches.new()
      expect(punch).to receive(:system).with(" open \"#{APP_ROOT}/punches.csv\" ")
      punch.open_csv
    end
  end
  context 'INVALID' do
    it 'displays notification' do
      tc = TimeClock.new(action: 'invalid')
      expect(tc).to receive(:system).with(" echo \"Invalid action. Use 'in, 'out', 'last' or 'open'.\" ")
      tc.launch!
    end
  end
end
