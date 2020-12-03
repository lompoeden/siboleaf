class Label < ApplicationRecord
  validates :label_type, presence: true, uniqueness:true
  has_many :associations, dependent: :destroy, foreign_key: 'label_id'
  has_many :tasks, through: :associations, source: :task
end
