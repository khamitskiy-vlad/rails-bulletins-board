# frozen_string_literal: true

class Bulletin < ApplicationRecord
  belongs_to :creator, class_name: 'User', inverse_of: :bulletins, counter_cache: :bulletins_count
  belongs_to :category
  has_one_attached :image

  validates :title, presence: true, length: { maximum: 50 }
  validates :description, presence: true, length: { maximum: 1000 }
  validates :image, attached: false,
                    content_type: %i[png jpg jpeg],
                    size: { less_than: 5.megabytes }

  def self.ransackable_attributes(_auth_object = nil)
    %w[title description]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[creator category]
  end
end
