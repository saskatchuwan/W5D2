class Sub < ApplicationRecord
  validates :description, :title, presence: true

  belongs_to :moderator,
    primary_key: :id,
    foreign_key: :moderator_id,
    class_name: :User

  # has_many :posts,
  #   primary_key: :id,
  #   foreign_key: :sub_id,
  #   class_name: :Post

  has_many :post_subs,
    primary_key: :id,
    foreign_key: :sub_id,
    class_name: :PostSub,
    inverse_of: :sub

  has_many :posts,
    through: :post_subs,
    source: :post

end
