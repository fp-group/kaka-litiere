class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  before_bugsnag_notify :add_ua_to_report

  def add_ua_to_report
    user_agent  = UserAgentParser.parse(request.user_agent)

    report.add_tab(:user_agent, {
      browser:  user_agent.family,
      version:  user_agent.version.to_s,
      os:       user_agent.os.to_s,
      device:   user_agent.device.family,
    })
  end
end
