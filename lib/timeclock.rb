# This class validates user input and controls actions based on the alfred
# query recieved from the user.
class TimeClock
  def initialize(params)
    params = params.merge!(date: Time.now.strftime('%m/%d/%Y'), time: Time.now.strftime('%R'))
    @action = params[:action]
    @note = params[:note]
    @punch = Punches.new(params)
  end

  def launch!
    case @action
    when :in, :out, :divider
      @punch.punch
    when :open
      @punch.open_csv
    end
    display_notification
  end

  private

  def action_valid?(symbol = '')
    whitelist = %w(in out last open divider)
    whitelist.include?(symbol.to_s)
  end

  def notification_text
    case @action
    when :in, :out
      "Clocked #{@action} at #{Time.now.strftime('%I:%M %p')}" << append_note(@note)
    when :last
      @punch.last.include?('**') ? 'Last punch added a divider' : "Last punch was at: #{@punch.last}" << append_note(@punch.last_note)
    when :divider
      "Added divider" << append_note(@note)
    when :open
      'Opening punches CSV'
    when nil
      "Missing action: Use 'in, 'out', 'last' or 'open'."
    else
      "Invalid action. Use 'in, 'out', 'last' or 'open'."
    end
  end

  def append_note(note)
    return "" if note == ""
    "\nNote - #{note}"
  end

  def display_notification
    system %( echo "#{notification_text}" )
  end
end
