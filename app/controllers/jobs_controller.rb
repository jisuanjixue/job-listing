class JobsController < ApplicationController
before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy, :favorite]
before_action :validate_search_key, only: [:search]
before_action :validate_city_key, only: [:city]
 def index
   @jobs = case params[:order]
   when 'by_lower_bound'
   Job.published.order('wage_lower_bound DESC')
   when 'by_upper_bound'
   Job.published.order('wage_upper_bound DESC')
   else
   Job.published.recent
 end
end

  def new
    @job = Job.new
  end

  def edit
    @job = Job.find(params[:id])
  end

  def show
    @job = Job.find(params[:id])
  if @job.is_hidden
  flash[:warning] = "This job already archieved"
redirect_to root_path
end
  end

  def create
    @job = Job.new(job_params)
  if @job.save
   redirect_to jobs_path
 else
   render :new
   end
 end

   def update
     @job = Job.find(params[:id])
     if @job.update(job_params)
       redirect_to jobs_path
     else
       render :edit
       end
     end

   def destroy
     @job = Job.find(params[:id])
     @job.destroy
    redirect_to jobs_path
  end

  def upvote
  @job = Job.find(params[:id])

   if !current_user.is_voter_of?(@job)
     current_user.upvote!(@job)
   end

   redirect_to :back
 end

 def downvote
   @job = Job.find(params[:id])

   if current_user.is_voter_of?(@job)
     current_user.downvote!(@job)
   end
   redirect_to :back
 end

  def search
      if @query_string.present?
        search_result = Job.published.ransack(@search_criteria).result(:distinct => true)
        @jobs = search_result.paginate(:page => params[:page], :per_page => 20 )
      end
    end

    def city
     if @cuery_string.present?
     city_result = Job.published.ransack(@city_criteria).result(:distinct => true)
       @jobs = city_result.paginate(:page => params[:page], :per_page => 6 )
     end
   end

    def favorite
    @job = Job.find(params[:id])
    type = params[:type]
    if type == "favorite"
    current_user.favorite_jobs << @job
    redirect_to :back

    elsif type == "unfavorite"
    current_user.favorite_jobs.delete(@job)
    redirect_to :back

    else
    redirect_to :back
    end
    end

    private

   def job_params
   params.require(:job).permit(:title, :description, :wage_upper_bound, :wage_lower_bound, :contact_email, :is_hidden, :category_id)
 end

 protected

 def validate_search_key
   @query_string = params[:q].gsub(/\\|\'|\/|\?/, "") if params[:q].present?
   @search_criteria = search_criteria(@query_string)
 end


 def search_criteria(query_string)
   { :title_description_cont => query_string }
 end

 def validate_city_key
    @cuery_string = params[:c].gsub(/\\|\'|\/|\?/, "") if params[:c].present?
    @city_criteria = {place_cont: @cuery_string}
  end

  def city_criteria(cuery_string)
    { :title_cont => cuery_string}
  end

end
