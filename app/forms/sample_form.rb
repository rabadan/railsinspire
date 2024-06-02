class SampleForm < Sample
  include ActiveFormModel

  permit :title, :description, :status, sample_files_attributes: %i[id _destroy path contents description]
  validates :title, presence: true
end
