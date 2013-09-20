Rails.application.config.middleware.use OmniAuth::Builder do
  
  provider :cas,
    :login_url => Bifrost::Application.config.cas[:login_url],
    :service_validate_url => Bifrost::Application.config.cas[:service_validate_url],
    :host => Bifrost::Application.config.cas[:host],
    :ssl => Bifrost::Application.config.cas[:ssl]
end

if Bifrost::Application.config.stub_authentication
  OmniAuth.config.test_mode = true
  OmniAuth.config.add_mock(:cas, {
    :uid => "username",
    :pid => "123456",
    :info => { :name => "Test User" },  
    :extra => {
      :user => "username",
    }
  })
end

OmniAuth.config.logger = Rails.logger