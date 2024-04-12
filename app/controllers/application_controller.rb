class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :set_csp_header

  private

  def set_csp_header
    response.headers['Content-Security-Policy'] = "frame-ancestors https://vincent-dev.netlify.app/"
  end
end
