require "net/http"
require "net/https"

module RingTwice
  @@api_settings = {}
  cattr_accessor :api_settings

  def send_mail(project, group, body)

    params =  {
      'username' => api_settings[:username],
      'api_key' =>  api_settings[:api_key],
      'project' => project,
      'group' => group,
      'body' => body
    }

    url = URL.parse(api_settings[:host])
    request = Net::HTTP::Post.new(url.path)
    request.set_form_data(params)
    response =  Net::HTTP.start(url.host, url.port) do |http|
      http.request(request)
    end

    case response
    when Net::HTTPSuccess
      response.body
    else
      response.error!
    end

  end
  
end