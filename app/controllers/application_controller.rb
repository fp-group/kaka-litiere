class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  before_bugsnag_notify :add_ua_to_bugsnag, :add_user_to_bugsnag

  def add_ua_to_bugsnag(report)
    user_agent  = UserAgentParser.parse(request.user_agent)

    report.add_tab(:user_agent, {
      browser:  user_agent.family,
      version:  user_agent.version.to_s,
      os:       user_agent.os.to_s,
      device:   user_agent.device.family,
    })
  end

  def add_user_to_bugsnag(report)
    report.user = {
      email:  current_user.email,
      name:   current_user.name,
      id:     current_user.id
    }
  end
end
