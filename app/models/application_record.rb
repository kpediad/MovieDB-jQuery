class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def error_msg
    if self.errors.any? then
      msg = "#{'Error'.pluralize(self.errors.count)}: "
      self.errors.full_messages.each do |message|
        msg = msg + "#{message} - "
      end
      msg.chop!.chop!.chop!
    else
      msg = 'No errors occured.'
    end
    return msg
  end
  
end
