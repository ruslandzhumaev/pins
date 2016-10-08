class Post < ApplicationRecord
  has_attached_file :image, styles: { medium: "600x600>", thumb: "200x200>" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  belongs_to :category
  belongs_to :user

  validates :category_id, presence: true
  validates :title, presence: true
  validates :text, presence: true

  extend FriendlyId
  friendly_id :title, use: :slugged

  def self.search(search)
    where("title LIKE ? OR text LIKE ?", "%#{search}%", "%#{search}%") 
  end
end
