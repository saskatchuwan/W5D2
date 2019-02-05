class Sub < ApplicationRecord
  validates :description, :title, presence: true

  belongs_to :moderator,
    primary_key: :id,
    foreign_key: :moderator_id,
    class_name: :User
end
