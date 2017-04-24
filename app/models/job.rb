class Job < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_many :favorites
  has_many :fans, through: :favorites, source: :user
  has_many :resumes
  has_many :job_relationships
  has_many :members, through: :job_relationships, source: :user

scope :published, -> { where(is_hidden: false) }
scope :recent, -> { order('created_at DESC') }
  def publish!
    self.is_hidden = false
  self.save
end

  def hide!
    self.is_hidden = true
    self.save
  end

  validates :title, presence: true
  validates :wage_upper_bound, presence: true
  validates :wage_lower_bound, presence: true
  validates :wage_lower_bound, numericality: { greater_than: 0}
end
