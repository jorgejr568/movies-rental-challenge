# frozen_string_literal: true

# Purpose: Authentication service
class AuthenticationService
  def initialize
    @jwt_secret = Rails.application.secrets.jwt_secret || 'secret'
    @jwt_algorithm = 'HS256'
    @jwt_duration = 1.hour
  end

  # @return [String]
  # @raise [CredentialsInvalid]
  def sign_in(email, password)
    @user = User.find_by(email:)
    raise CredentialsInvalid unless @user && BCrypt::Password.new(@user.password) == password

    _generate_jwt
  end

  def validate_token(token)
    JWT.decode token, @jwt_secret, true, { algorithm: @jwt_algorithm }
  rescue JWT::DecodeError => e
    raise CredentialsInvalid, e.message
  end

  def _generate_jwt
    JWT.encode(
      {
        user_id: @user.id,
        user_name: @user.name,
        user_email: @user.email
      },
      @jwt_secret,
      @jwt_algorithm,
      { exp: @jwt_duration.from_now.to_i }
    )
  end
end
