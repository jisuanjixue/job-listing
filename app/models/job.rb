class Job < ApplicationRecord
  has_many :votes
  has_many :voters, through: :votes, source: :user
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

  validates :title, presence: { message: "请填写职位名称" }
  validates :description, presence: { message: "请填写职位描述" }
  validates :wage_upper_bound, presence: { message: "请填写最高薪水" }
  validates :wage_lower_bound, presence: { message: "请填写最低薪水" }
  validates :wage_lower_bound, numericality: { less_than: :wage_upper_bound, message: "薪水下限不能高于薪水上限" }
  validates :wage_upper_bound, numericality: { greater_than: 0, message: "最小薪水必须大于零" }
  validates :contact_email, presence: { message: "请填写联系用的邮箱" }
  validates_format_of :contact_email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i , message: "请输入正确的邮箱格式"
end
