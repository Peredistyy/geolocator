module Locator
  class Tasks < Grape::API
    include Extension::Authenticate
    include Extension::EventStore

    resource :tasks do
      desc 'Create a task.'
      params do
        requires :token, type: String, desc: 'Token', documentation: { param_type: 'query' }
        requires :destination, type: String, desc: 'IP address or URL', documentation: { param_type: 'query' }
        requires :action,
                 type: Symbol,
                 values: %i[add remove],
                 desc: 'Action: "add" or "remove"',
                 documentation: { param_type: 'query' }
      end
      post do
        authenticate!

        begin
          ip = IPSocket::getaddress(params[:destination])
        rescue SocketError
          error!('destination is not valid', 400)
        end

        case params[:action]
        when :add
          event_store.publish(AddGeoLocationCommand.new(data: { ip: ip }), stream_name: 'tasks')
        when :remove
          event_store.publish(RemoveGeoLocationCommand.new(data: { ip: ip }), stream_name: 'tasks')
        else
          error!("'#{params[:action]}' is a wrong action type.", 502)
        end

        { success: true }
      end
    end
  end
end