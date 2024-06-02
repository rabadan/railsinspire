module SampleService
  def self.create_post(sample)
    sample.save!
    ProcessSampleJob.perform_async(sample.id)
    User.moderators.each { |user| SampleMailer.to_moderation(user, sample).deliver_later }

    sample
  end

  def self.moderate_post(sample)
    sample.save!
    sample.moderated

    ProcessSampleJob.perform_async(sample.id)
    PublishGistJob.perform_async(sample.id)
    PublishTwitterJob.perform_async(sample.id) if sample.in_twitter?

    sample
  end
end
