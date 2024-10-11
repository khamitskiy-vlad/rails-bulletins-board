# frozen_string_literal: true

class Bulletin < ApplicationRecord
  include AASM

  has_many_attached :image
  belongs_to :category, counter_cache: :bulletins_count
  belongs_to :creator,
    class_name: 'User',
    inverse_of: :bulletins,
    counter_cache: :bulletins_count

  validates :title,
    presence: true,
    length: { maximum: 50 }
  validates :description,
    presence: true,
    length: { maximum: 1000 }
  validates :image,
    attached: false,
    content_type: %i[png jpg jpeg],
    size: { less_than: 5.megabytes }

    aasm do
      state :draft, initial: true
      state :moderation
      state :published
      state :archived
  
      event :to_moderation do
        transitions from: :draft, to: :moderation
      end
  
      event :publish do
        transitions from: :under_moderation, to: :published
      end
  
      event :archive do
        transitions from: %i[draft published], to: :archived
      end

      event :to_correction do
        transsitions from :moderation, to: :draft
      end
    end

  def self.ransackable_attributes(_auth_object = nil)
    %w[title description]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[creator category]
  end
end
