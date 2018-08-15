class PartsController < ApplicationController
  Part = Struct.new(:video, :name)

  def index
    @parts = build_parts
  end

  private

  def build_parts
    params.fetch(:parts, []).map do |part|
      attributes = part.fetch(:part).values_at(
        :video,
        :name,
      )

      Part.new(attributes)
    end
  end
end
