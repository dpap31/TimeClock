# This class manages the creation of the CSV that tracks punches. It also
# handles appending new timeclock entries based on query
class TimeClock
  COLUMN_HEADERS = %w(Date In Out Note)
  PUNCHES_PATH = File.join(APP_ROOT, 'punches.csv')

  def initialize(action, note = '')
    File.exist?(PUNCHES_PATH) ? (file_usable?) : (create_file)
    @note = note
    action_loop(action)
  end

  private

  def action_loop(action)
    case action.downcase
    when 'in'
      clock_in
    when 'out'
      clock_out
    else
      puts 'unrecognized action'
    end
  end

  def create_file
    CSV.open(PUNCHES_PATH, 'w') do |csv|
      csv << COLUMN_HEADERS
    end
  end

  def count_length
    CSV.read(PUNCHES_PATH).length
  end

  def append_file(arr)
    CSV.open(PUNCHES_PATH, 'ab') do |csv|
      csv << arr
    end
  end

  def file_usable?
    return false unless PUNCHES_PATH
    return false unless File.exist?(PUNCHES_PATH)
    return false unless File.readable?(PUNCHES_PATH)
    return false unless File.writable?(PUNCHES_PATH)
    return true
  end

  def clock_in
    arr = [Time.now.strftime('%m/%d/%Y'), Time.now.strftime('%R'), '', @note]
    append_file(arr)
  end

  def clock_out
    arr = [Time.now.strftime('%m/%d/%Y'), '', Time.now.strftime('%R'), @note]
    append_file(arr)
  end
end
