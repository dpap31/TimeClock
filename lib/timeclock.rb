# This class manages the creation of the CSV that tracks punches. It also
# handles appending new timeclock entries based on query
class TimeClock
  PUNCHES_PATH = File.join(APP_ROOT, 'punches.csv')

  def initialize(params)
    File.exist?(PUNCHES_PATH) ? (file_usable?) : (create_file)
    @action = action_valid?(params[:action])
    @note = params[:note]
    @notification = notification_text
    action_loop
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

  def last_punch
    arr = []
    CSV.foreach(PUNCHES_PATH, headers: true) { |punch| arr << punch }
    punch = [arr.last[1], arr.last[2]].compact.reject { |e| e.to_s.empty? }.pop
    punch_time = Time.strptime(punch, '%R').strftime('%I:%M %p')
    "Last punch was at: #{punch_time}"
  end

  def action_valid?(string = '')
    white_list = %w(in out last)
    white_list.include?(string.downcase) ? string.downcase.to_sym : :invalid
  end

  def notification_text
    case @action
    when :in, :out
      "Clocked #{@action} at #{Time.now.strftime('%I:%M %p')}"
    when :last
      last_punch
    when nil
      "Missing action: Use 'in or 'out'."
    else
      "Invalid action: #{@action}. Use 'in or 'out'."
    end
  end

  def punch
    @action == :in ? (arr = clock_in) : (arr = clock_out)
    append_file(arr)
  end

  def clock_in
    [Time.now.strftime('%m/%d/%Y'), Time.now.strftime('%R'), '', @note]
  end

  def clock_out
    [Time.now.strftime('%m/%d/%Y'), '', Time.now.strftime('%R'), @note]
  end

  def action_loop
    case @action
    when :in, :out
      punch
      system %( echo "#{@notification}" )
    when :last
      system %( echo "#{@notification}" )
    when :invalid
      system %( echo "#{@notification}" )
    end
  end
end
