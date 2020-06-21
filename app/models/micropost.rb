class Micropost < ApplicationRecord
  belongs_to :user
  # Default: foreign_key: user_id <-> User
  has_one_attached :image
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validates :image,   content_type: { in: %w[image/jpeg image/gif image/png],
                                      message: "must be a valid image format" },
                      size:         { less_than: 1.megabytes,
                                      message: "should be less than 1MB" }

  # 表示用のりサイズ済み画像を返す
  def display_image
    image.variant(resize_to_limit: [500, 500])
  end
end
