class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def default_headers
    headers['X-Frame-Options'] = 'https://vincent-dev.netlify.app/'
  end

  private

  def set_default_headers
    response.headers['X-Frame-Options'] = 'ALLOW-FROM https://vincent-dev.netlify.app/'
  end
end
