class User < ApplicationRecord
has_many :votes
has_many :voted_jobs, :through => :votes, :source => :job
has_many :jobs
has_many :favorites
has_many :favorite_jobs, :through => :favorites, :source => :job
has_many :resumes
has_many :job_relationships
has_many :applied_jobs, :through => :job_relationships, :source => :job
devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

def upvote!(job)
  voted_jobs << job
end

def downvote!(job)
  voted_jobs.delete(job)
end


def is_voter_of?(job)
  voted_jobs.include?(job)
end

def admin?
  is_admin
  end

 def has_applied?(job)
   applied_jobs.include?(job)
 end

 def apply!(job)
 applied_jobs << job
end

  def is_favorite_of?(job)
  favorite_jobs.include?(job)
  end

  def display_name
  if self.username.present?
    self.username
  else
    self.email.split("@").first
  end
end
end
