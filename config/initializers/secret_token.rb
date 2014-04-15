# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
Bitt3r::Application.config.secret_key_base = 'bdc09960f17a3a249fce94c69b41ebbb8dd9bfbce226679822cfe000d376699232e7cfa8412f9132a05ee8ebd34c49e63460cf7e6edd25a759a3ee7e71941c6b'

require 'securerandom'

def secure_token
  token_file = Rails.root.join('.secret')
  if File.exist?(token_file)
    # Use existing token
    File.read(token_file).chomp
  else
    # Generate a new token and store it in token_file
    token = SecureRandom.hex(64)
    File.write(token_file, token)
  end
end

Bitt3r::Application.config.secret_key_base = secure_token