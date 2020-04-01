class Review < ApplicationRecord
  belongs_to :shelter
  validates_presence_of :title, :rating, :content
  after_initialize :init

  def init
    if self.image == ""
      self.image = "https://media.npr.org/assets/img/2013/02/06/dog_wide-e19af42dcba6ac82e35773015db5d04ef49c9beb-s800-c85.jpg"
    end
  end

end
