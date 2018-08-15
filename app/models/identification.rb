class Identification
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :artist, :string
  attribute :song, :string
end
