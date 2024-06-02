module Samples
  class ModerateController < ApplicationController
    before_action :set_sample, only: %i[edit update]

    def edit
      authorize(@sample, :moderate?, policy_class: SamplePolicy)
      return if @sample.created?
      return redirect_to(sample_path(@sample)), alert: "Sample has already passed moderation"
    end

    def update
      authorize(@sample, :moderate?, policy_class: SamplePolicy)
      @sample.assign_attributes(params[:sample_moderate_form])
      return render('samples/moderate/edit', status: :unprocessable_entity) unless @sample.valid?

      @sample = SampleService.moderate_post(@sample)
      return redirect_to(sample_path(@sample))
    end

    private

    def set_sample
      @sample = Sample.find(params[:sample_id]).becomes(SampleModerateForm)
    end
  end
end
