class ApplicationController < ActionController::API
  def initialize
    super
    @authentication_service = AuthenticationService.new
  end

  def authorize_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    begin
      @decoded = @authentication_service.validate_token header
      @current_user = User.find(@decoded[0]['user_id'])
    rescue CredentialsInvalid => e
      render json: { error: e.message }, status: :unauthorized
    end
  end
end