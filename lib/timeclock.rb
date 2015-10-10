# This class validates user input and controls actions based on the alfred
# query recieved from the user.
class TimeClock
  def initialize(params)
    @punch = Punches.new
    @action = action_valid?(params[:action])
    @note = params[:note]
    @notification = notification_text
  end

  def launch!
    case @action
    when :in, :out
      @punch.punch(@action)
    when :divider
      @punch.divider(@note)
    when :open
      @punch.open_csv
    end
    display_notification
  end

  private

  def action_valid?(string = '')
    whitelist = %w(in out last open divider)
    whitelist.include?(string.downcase) ? string.downcase.to_sym : :invalid
  end

  def notification_text
    case @action
    when :in, :out
      "Clocked #{@action} at #{Time.now.strftime('%I:%M %p')}"
    when :last
      @punch.last.include?('**') ? 'Last punch added a divider' : "Last punch was at: #{@punch.last}"
    when :divider
      "Added divider: '#{@note}'"
    when :open
      'Opening punches CSV'
    when nil
      "Missing action: Use 'in, 'out', 'last' or 'open'."
    else
      "Invalid action. Use 'in, 'out', 'last' or 'open'."
    end
  end

  def display_notification
    system %( echo "#{@notification}" )
  end
end
