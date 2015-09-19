require 'csv'
require 'time'
# This class manages the creation of the CSV that tracks punches. It also
# controls actions based on alfred query
class Punches
  # APP_ROOT = File.dirname(__FILE__)
  # $LOAD_PATH.unshift(File.join(APP_ROOT, 'lib'))
  PUNCHES_PATH = File.join(APP_ROOT, 'punches.csv')

  def initialize
    File.exist?(PUNCHES_PATH) ? (file_usable?) : (create_file)
  end

  def punch(action)
    action == :in ? (arr = clock_in) : (arr = clock_out)
    append_file(arr)
  end

  def open_csv
    system %( open "#{PUNCHES_PATH}" )
  end

  def last
    arr = []
    CSV.foreach(PUNCHES_PATH, headers: true) { |punch| arr << punch }
    punch = [arr.last[1], arr.last[2]].compact.reject { |e| e.to_s.empty? }.pop
    Time.strptime(punch, '%R').strftime('%I:%M %p')
  end

  private

  def file_usable?
    return false unless PUNCHES_PATH
    return false unless File.exist?(PUNCHES_PATH)
    return false unless File.readable?(PUNCHES_PATH)
    return false unless File.writable?(PUNCHES_PATH)
    return true
  end

  def create_file
    column_headers = %w(Date In Out Note)
    CSV.open(PUNCHES_PATH, 'w') do |csv|
      csv << column_headers
    end
  end

  def append_file(arr)
    CSV.open(PUNCHES_PATH, 'ab') do |csv|
      csv << arr
    end
  end

  def clock_in
    [Time.now.strftime('%m/%d/%Y'), Time.now.strftime('%R'), '', @note]
  end

  def clock_out
    [Time.now.strftime('%m/%d/%Y'), '', Time.now.strftime('%R'), @note]
  end
end
