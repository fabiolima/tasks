class User
  include ActiveModel::API
  include ActiveModel::Validations
  extend ActiveModel::Callbacks
  extend Devise::Models

  # Attach model callbacks only to validation method.
  define_model_callbacks :validation

  attr_accessor :email, :password, :token

  devise :remote_authenticatable, :timeoutable
end
