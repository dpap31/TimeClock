# This class manages the creation of the CSV that tracks punches. It also
# controls actions based on alfred query
class Punches
  PUNCHES_PATH = File.join(APP_ROOT, 'punches.csv')

  def initialize
    File.exist?(PUNCHES_PATH) ? (file_usable?) : (create_file)
  end

  def punch(action)
    action == :in ? (punch = clock_in) : (punch = clock_out)
    append_file(punch)
  end

  def divider(title = '')
    title.empty? ? (arr = add_divider('Divider')) : (arr = add_divider(title))
    append_file(arr)
  end

  def open_csv
    system %( open "#{PUNCHES_PATH}" )
  end

  def last
    arr = []
    CSV.foreach(PUNCHES_PATH, headers: true, row_sep: :auto) { |punch| arr << punch }
    punch = [arr.last[1], arr.last[2]].compact.reject { |e| e.to_s.empty? }.pop
    punch.include?('**') ? punch : (Time.strptime(punch, '%R').strftime('%I:%M %p'))
  end

  private

  def file_usable?
    return false unless PUNCHES_PATH
    return false unless File.exist?(PUNCHES_PATH)
    return false unless File.readable?(PUNCHES_PATH)
    return false unless File.writable?(PUNCHES_PATH)
    true
  end

  def create_file
    column_headers = %w(Date In Out Note)
    CSV.open(PUNCHES_PATH, 'w', row_sep: :auto) do |csv|
      csv << column_headers
    end
  end

  def append_file(arr)
    CSV.open(PUNCHES_PATH, 'a+', row_sep: :auto) do |csv|
      missing_line_break? ?  (csv << [] << arr): (csv << arr)
    end
  end

  def missing_line_break?
    last_character = `tail -c 1 #{PUNCHES_PATH}`
    last_character == ',' ? true : false
  end

  def clock_in
    [Time.now.strftime('%m/%d/%Y'), Time.now.strftime('%R'), '', @note]
  end

  def clock_out
    [Time.now.strftime('%m/%d/%Y'), '', Time.now.strftime('%R'), @note]
  end

  def add_divider(title)
    ['**********', title.upcase, '**********', '']
  end
end
