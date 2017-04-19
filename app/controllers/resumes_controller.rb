class ResumesController < ApplicationController
  before_action :authenticate_user!

  def new
    @job = Job.find(params[:job_id])
    @resume = Resume.new
  end

   def create
    @job = Job.find(params[:job_id])
    @resume = Resume.new(resume_params)
    @resume.job = @Job
    @resume.user = current_user

  if @resume.save
 current_user.apply!(@job)
  flash[:notice] = "你成功提交履历"
  redirect_to job_path(@job)
else
 render :new
  end
end

 private

  def resume_params
   params.require(:resume).permit(:content, :attachment)
 end
end
