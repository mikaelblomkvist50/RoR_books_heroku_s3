class Book < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: [:slugged, :history]

  def should_generate_new_friendly_id?
    slug.blank? || title_changed?
  end

  mount_uploader :book_cover, BookCoverUploader
  validate :book_cover_size

  private

    # Validates the size of an uploaded picture.
    def book_cover_size
      if book_cover.size > 2.megabytes
        errors.add(:book_cover, "should be less than 2MB")
      end
    end
end
