module Extension
  module EventStore
    def self.included(base)
      base.class_eval do
        helpers do
          def event_store
            Rails.configuration.event_store
          end
        end
      end
    end
  end
end
