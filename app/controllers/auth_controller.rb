# frozen_string_literal: true

# Purpose: Authentication controller
class AuthController < ApplicationController
  before_action :authorize_request, except: :sign_in

  def initialize
    super

    @service = AuthenticationService.new
  end

  def sign_in
    token = @service.sign_in params[:email], params[:password]
    render json: { token: }
  rescue CredentialsInvalid => e
    render json: { error: e.message }, status: :unauthorized
  end

  def me
    render json: @current_user
  end
end
