class Blog < ApplicationRecord
  belongs_to :user
  has_many :comments

  def new_line
    arr = self.content.split("\n")
  end
end
