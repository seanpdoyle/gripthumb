class UnknownSong
  include ActiveModel::Conversion

  def artist
    ""
  end

  def name
    ""
  end

  def parts
    []
  end
end
