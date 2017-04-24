class Admin::JobsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

 layout "admin"

    def index
      if params[:category].blank?
        @jobs= Job.where(is_hidden: false).order("created_at DESC")
      else
        @category_id = Category.find_by(name: params[:category]).id
        @jobs = Job.where(:category_id => @category_id).order("created_at DESC")
      end
    end

    def new
      @job = Job.new
      @categories = Category.all.map { |c| [c.name, c.id] }
    end

    def edit
      @job = Job.find(params[:id])
      @categories = Category.all.map { |c| [c.name, c.id] }
    end

    def show
      @job = Job.find(params[:id])
    end

    def create
      @job = Job.new(job_params)
      @job.category_id = params[:category_id]
    if @job.save
     redirect_to admin_jobs_path
   else
     render :new
     end
   end

     def update
       @job = Job.find(params[:id])
       @job.category_id = params[:category_id]
       if @job.update(job_params)
         redirect_to admin_jobs_path
       else
         render :edit
         end
       end

     def destroy
       @job = Job.find(params[:id])
       @job.destroy
      redirect_to admin_jobs_path
    end

   def publish
     @job = Job.find(params[:id])
     @job.publish!
redirect_to :back
end

  def hide
    @job = Job.find(params[:id])
    @job.hide!
    redirect_to :back
    end

      private

     def job_params
     params.require(:job).permit(:title, :description, :wage_upper_bound, :wage_lower_bound, :contact_email, :is_hidden, :category_id)
   end
end
