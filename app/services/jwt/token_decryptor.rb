module Jwt::TokenDecryptor
  extend self

  def call(token)
    decrypt(token)
  end

  private

  def decrypt(token)
    JWT.decode(token, Rails.application.credentials.secret_key_base)
  rescue StandardError
    raise InvalidTokenError
  end
end
class InvalidTokenError < StandardError; end