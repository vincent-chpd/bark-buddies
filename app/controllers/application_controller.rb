class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :set_x_frame_options

  private

  def set_x_frame_options
    response.headers['X-Frame-Options'] = 'ALLOW-FROM https://vincent-dev.netlify.app/'
  end
end
