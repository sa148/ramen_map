class Contribution < ApplicationRecord
  belongs_to :customer
  has_many :tagmaps, dependent: :destroy
  has_many :tags, through: :tagmaps
  has_one_attached :image

  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [200, 200]).processed
  end

   def save_tag(sent_tags)
    current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
    old_tags = current_tags - sent_tags
    new_tags = sent_tags - current_tags

    old_tags.each do |old|
      self.tags.delete Tag.find_by(tag_name: old)
    end

    new_tags.each do |new|
      new_contribution_tag = Tag.find_or_create_by(tag_name: new)
      self.tags << new_contribution_tag
    end
   end

end
