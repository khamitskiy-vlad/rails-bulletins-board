# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password validations: false
  has_many :bulletins,
    foreign_key: 'creator_id',
    inverse_of: :creator,
    dependent: :destroy

  validates :name, presence: true
  validates :email,
    format: { with: URI::MailTo::EMAIL_REGEXP },
    presence: true,
    uniqueness: true
  validates :password,
    presence: true,
    length: { minimum: 6 },
    format: /\A(?=.*[a-zA-Z])(?=.*[0-9]).{6,}\z/,
    confirmation: true,
    unless: Proc.new { |user| user.password.blank? }

  def self.from_omniauth(omniauth_params)
    omniauth_email = omniauth_params.info.email

    user = User.find_or_initialize_by(email: omniauth_email)
    user.name = omniauth_params.info.name
    user.save
    user
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[name email]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[bulletins]
  end
end
