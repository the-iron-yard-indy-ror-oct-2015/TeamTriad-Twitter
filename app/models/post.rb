class Post < ActiveRecord::Base

  belongs_to :user
   validates_presence_of :blurb
   validates :blurb, length: { maximum: 170,
     too_long: "%{count} characters is the maximum allowed" }
end
