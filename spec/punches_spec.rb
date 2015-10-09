require 'spec_helper'

describe 'initialize' do
  it 'does not have an existing punches.csv' do
  end
  it 'does has an existing punches.csv' do
  end
end

describe '#punch' do
  subject { Punches.new }
  it 'appends IN punch to end of CSV file' do
    subject.punch(:in)
    expect(subject.last).to eq(Time.now.strftime('%I:%M %p'))
  end
  it 'appends OUT punch to end of CSV file' do
    subject.punch(:in)
    expect(subject.last).to eq(Time.now.strftime('%I:%M %p'))
  end
end

describe '#opens_csv' do
  it 'prints open file to system' do
    punch = Punches.new
    expect(punch).to receive(:system).with(" open \"#{APP_ROOT}/punches.csv\" ")
    punch.open_csv
  end
end
