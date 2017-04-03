class User < ApplicationRecord
has_many :jobs
  has_many :favorites
  has_many :favorite_jobs, :through => :favorites, :source => :job
  has_many :resumes
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

         def admin?
             email == 'r@qq.com'
  end

  def is_favorite_of?(job)
  favorite_jobs.include?(job)
  end
end
