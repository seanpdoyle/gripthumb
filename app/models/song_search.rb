class SongSearch
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :artist, :string
  attribute :title, :string

  def results
    [
      { part: { video: "The 917 Video", name: "Aaron Loreth" } },
    ]
  end
end
