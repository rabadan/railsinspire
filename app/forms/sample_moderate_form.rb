class SampleModerateForm < Sample
  attr_accessor :in_twitter
  include ActiveFormModel

  permit :title, :description, :status, :category_id, :in_twitter,
         sample_files_attributes: %i[id _destroy path contents description]

  validates :title, :category, presence: true

  def in_twitter?
    in_twitter.to_s == '1'
  end
end
