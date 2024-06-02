class SamplesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]

  def show
    @sample = Sample.find(params[:id])
    @sample_file = @sample.sample_files.first
    authorize @sample

    render "sample_files/show"
  end

  def new
    @sample = current_user.samples.new
    @sample.sample_files.new
    authorize @sample
  end

  def create
    authorize Sample
    @sample = SampleForm.new(sample_params)
    @sample.user = current_user
    return render(:new, status: :unprocessable_entity) unless @sample.valid?

    @sample = SampleService.create_post(@sample)
    redirect_to sample_path(@sample.id)
  end

  def edit
    @sample = current_user.samples.find(params[:id])
    authorize @sample
  end

  def update
    @sample = current_user.samples.find(params[:id])
    authorize @sample

    if @sample.update(sample_params)
      ProcessSampleJob.perform_async(@sample.id)
      redirect_to @sample
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def sample_params
    params.require(:sample).permit(
      :title, :description, :category_id, :status,
      sample_files_attributes: [:id, :_destroy, :path, :contents, :description]
    )
  end
end
