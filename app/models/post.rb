class Post < ApplicationRecord
  has_attached_file :image, styles: { medium: "600x600>", thumb: "200x200>" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  belongs_to :category
  belongs_to :user

  validates :category_id, presence: true
  validates :title, presence: true
  validates :text, presence: true
end
