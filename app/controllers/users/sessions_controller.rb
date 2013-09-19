

class Users::SessionsController < ApplicationController
  skip_before_filter :authenticate_conditionally, :only => [ :create, :new ]

  def new
    session[:return_url] = Rails.configuration.action_controller.relative_url_root
    redirect_to omniauth_path(:cas)
  end

  def create

    # extract authentication data
    auth = request.env["omniauth.auth"]
    logger.debug auth.extra.hashie_inspect
    provider = params['provider']
    username = auth.extra.user

    session[:user] = auth
    res_arg = 'return_url'
    res_url = session.delete(res_arg)
    logger.info "Redirecting to: #{res_url.to_s} for #{res_arg}"
    redirect_to res_url || root_url, :notice => "logged in #{auth.extra.gn} #{auth.extra.sn}", :only_path => true
    #redirect_to root_url, :notice => "logged in #{auth.extra.gn} #{auth.extra.sn}", :only_path => true
  end

  def destroy
    reset_session
    redirect_to root_path
  end

  def omniauth_path(provider)
    "/auth/#{provider.to_s}"
  end

  def switch
    render(:file => 'public/401', :format => :html, :status => :unauthorized) and return unless can? :switch, User
  end

end
