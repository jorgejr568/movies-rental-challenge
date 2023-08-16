# frozen_string_literal: true

class CredentialsInvalid < Exception
  def initialize(msg = 'Credentials invalid')
    super
  end
end
