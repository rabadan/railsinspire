class SampleMailer < ApplicationMailer
  def to_moderation(user, sample)
    @sample = sample
    mail(to: user.email, subject: "Your sample is under moderation - #{sample.title}")
  end

  def gist_published(sample, link)
    @sample = sample
    @link = link
    mail(to: sample.user.email, subject: "Your sample gist is published - #{sample.title}")
  end
end
