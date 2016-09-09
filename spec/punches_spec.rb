require 'spec_helper'

describe 'initialize' do
  it 'creates new punches.csv' do
    rm_punches_csv if File.file?("#{APP_ROOT}/punches.csv")
    expect(File.file?("#{APP_ROOT}/punches.csv")).to eq(false)
    Punches.new(action: :in)
    expect(File.file?("#{APP_ROOT}/punches.csv")).to eq(true)
  end
  it 'does has an punches.csv' do
    expect(File.file?("#{APP_ROOT}/punches.csv")).to eq(true)
  end
end

describe '#punch' do
  subject { Punches.new(action: :in, note: '', date: Time.now.strftime('%m/%d/%Y'), time:  Time.now.strftime('%R')) }
  it 'appends IN punch to end of CSV file' do
    subject.punch
    expect(subject.last).to eq(Time.now.strftime('%I:%M %p'))
  end
end

describe '#punch out' do
  subject { Punches.new(action: :out, note: '', date: Time.now.strftime('%m/%d/%Y'), time:  Time.now.strftime('%R')) }
  it 'appends OUT punch to end of CSV file' do
    subject.punch
    expect(subject.last).to eq(Time.now.strftime('%I:%M %p'))
  end
end

describe '#divider' do
  subject { Punches.new(action: :divider, note: '') }
  it 'appends divider to end of CSV file' do
    subject.punch
    expect(subject.last).to eq('**********')
  end
end

describe '#opens_csv' do
  it 'prints open file to system' do
    punch = Punches.new(action: :open)
    expect(punch).to receive(:system).with(" open \"#{APP_ROOT}/punches.csv\" ")
    punch.open_csv
  end
end
