class PublishTwitterJob
  include Sidekiq::Job

  def perform(sample_id)
    sample = Sample.find(sample_id)
    link = Rails.application.routes.url_helpers.sample_url(sample)

    # TODO: TwitterManager.publish(link, sample.title, sample.description)
  end
end
