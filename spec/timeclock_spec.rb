require 'spec_helper'

describe 'initialize' do
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
      expect(@tc.instance_variable_get(:@notification)).to include('Clocked in at')
    end
  end
  context 'OUT action' do
    before(:all) do
      params = { action: 'out', note: 'note' }
      @tc = TimeClock.new(params)
    end
    it 'has valid action' do
      expect(@tc.instance_variable_get(:@out)).to eq(:out)
    end
    it 'has valid note' do
      expect(@tc.instance_variable_get(:@note)).to eq('note')
    end
    it 'has valid notification text' do
      expect(@tc.instance_variable_get(:@notification)).to include('Clocked out at')
    end
  end
end
