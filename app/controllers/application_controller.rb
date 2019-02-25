class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  def http_request(url, method, form_params=nil)
    url = URI(URI.escape(url))

    http = Net::HTTP.new(url.host, url.port)

    http.use_ssl = true unless Rails.env.development?
    http.read_timeout = 10000000
    if !Rails.env.development? then
      http.proxy_address = "http://#{   Rails.application.secrets.antechamber[:proxy_user]}:#{  Rails.application.secrets.antechamber[:proxy_password]}@mr-proxy.warwickshire.gov.uk"
      http.proxy_port = 3128
      http.proxy_user = Rails.application.secrets.antechamber[:proxy_user]
      http.proxy_pass = Rails.application.secrets.antechamber[:proxy_password]
    end
    
    if method == "get" then
      request = Net::HTTP::Get.new(url)
    elsif method == "post" then
      request = Net::HTTP::Post.new(url)
    elsif method == "delete" then
      request = Net::HTTP::Delete.new(url)
    elsif method == "patch" then
      request = Net::HTTP::Patch.new(url)
    end

    if form_params != nil then
      request.set_form_data(form_params, ':')
    end
      
    response = http.request(request)
      
    return response
  end
      
  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :display_name])
  end
      
end
