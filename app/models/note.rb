class Note < ActiveRecord::Base
  belongs_to :user
  has_many :note_comments
end
