module Provider
  class Base
    def geo_data_by_ip(ip)
      raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
    end
  end
end