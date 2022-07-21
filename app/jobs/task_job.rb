class TaskJob < ActiveJob::Base
  self.queue_adapter = :delayed_job

  def perform(ip, action)
    case action
    when :add
      service.add(ip)
    when :remove
      service.remove(ip)
    else
      raise ArgumentError, "'#{action}' is a wrong action type."
    end
  end

  private

  def service
    @service ||= GeolocationService.new
  end
end