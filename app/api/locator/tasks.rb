module Locator
  class Tasks < Grape::API
    include Extension::Authenticate

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

        TaskJob.perform_later(ip, params[:action]) && { success: true }
      end
    end
  end
end