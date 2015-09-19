require 'punches'
require 'time'
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
      display_notification
    when :last
      display_notification
    when :open
      @punch.open_csv
    when :invalid
      display_notification
    end
  end

  private

  def action_valid?(string = '')
    white_list = %w(in out last open)
    white_list.include?(string.downcase) ? string.downcase.to_sym : :invalid
  end

  def notification_text
    case @action
    when :in, :out
      "Clocked #{@action} at #{Time.now.strftime('%I:%M %p')}"
    when :last
      "Last punch was at: #{@punch.last}"
    when nil
      "Missing action: Use 'in or 'out'."
    else
      "Invalid action: #{@action}. Use 'in or 'out'."
    end
  end

  def display_notification
    system %( echo "#{@notification}" )
  end
end
