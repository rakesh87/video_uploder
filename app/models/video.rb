class Video < ActiveRecord::Base
  validates :file, presence: true
end
