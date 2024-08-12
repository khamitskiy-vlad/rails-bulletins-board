class Profile < ApplicationRecord
  belongs_to :user, dependent: :destroy
  has_many :bulletins,
    foreign_key: 'creator_id',
    inverse_of: :creator,
    dependent: :destroy

  has_one_attached :avatar

  validates :avatar, attached: false,
                    content_type: %i[png jpg jpeg],
                    size: { less_than: 5.megabytes }
  validates :summary, length: { maximum: 500 }
end
