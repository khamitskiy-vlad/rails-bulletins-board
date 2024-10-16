# frozen_string_literal: true

class User < ApplicationRecord
  has_many :bulletins, foreign_key: 'creator_id', inverse_of: :creator, dependent: :destroy

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, presence: true, uniqueness: true

  def self.from_omniauth(omniauth_params)
    omniauth_email = omniauth_params.info.email

    user = User.find_or_initialize_by(email: omniauth_email)
    user.name = omniauth_params.info.name
    user.save
    user
  end
end
