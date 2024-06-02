class PublishGistJob
  include Sidekiq::Job

  def perform(sample_id)
    sample = Sample.find(sample_id)
    sample_link = Rails.application.routes.url_helpers.sample_url(sample)

    # TODO: gist_link = GistManager.publish(sample_link, sample.title, sample.description)
    gist_link = "https://gist.github.com/anonymous/123456"

    SampleMailer.gist_published(sample, gist_link).deliver_now
  end
end
