class Micropost < ApplicationRecord
  MICROPOST_PARAMS_PARAMS = %i(content picture).freeze

  belongs_to :user
  has_one_attached :image
  delegate :name, to: :user, prefix: :user

  scope :by_created_at, -> { order(created_at: :desc) }
  scope :find_by_user_ids, ->(user_ids){where user_id: user_ids}
  
  validates :user_id, presence: true
  validates :content, presence: true,
    length: {maximum: Settings.validations.micropost.content_maxlength}
  validates :image,
    content_type: {in: Settings.validations.micropost.content_type,
                  message: I18n.t("microposts.errors.image_format")},
    size: {less_than: Settings.size.max_file_size.megabytes,
          message: I18n.t("microposts.errors.size_too_big")}

  def display_image
    image.variant resize_to_limit: [Settings.validations.micropost.resize_to_limit,
                                    Settings.validations.micropost.resize_to_limit]
  end
end
