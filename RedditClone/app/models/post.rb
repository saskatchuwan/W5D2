class Post < ApplicationRecord
  validates :title, presence: true

  # belongs_to :sub,
  #   primary_key: :id,
  #   foreign_key: :sub_id,
  #   class_name: :Sub

  belongs_to :author,
    primary_key: :id,
    foreign_key: :author_id,
    class_name: :User

  has_many :post_subs,
    primary_key: :id,
    foreign_key: :post_id,
    class_name: :PostSub

  has_many :subs,
    through: :post_subs,
    source: :sub
end
