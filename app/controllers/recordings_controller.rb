require "net/http"

class RecordingsController < ApplicationController
  def create
    result = audd_response[:result]

    if result
      redirect_to parts_url(result.slice(:artist, :title))
    else
      head 422
    end
  end

  private

  def audd_response
    endpoint = URI("https://api.audd.io")

    post = Net::HTTP::Post.new(endpoint)
    post.set_form(recording_params.to_h.to_a, "multipart/form-data")

    http_response = Net::HTTP.start(endpoint.hostname, endpoint.port, use_ssl: true) { |http| http.request(post) }

    JSON.parse(http_response.body, symbolize_names: true)
  end

  def recording_params
    params.permit(:return, :file)
      .rewrite(:file) { |file| file&.open }
      .merge(api_token: Rails.configuration.x.audd.api_token)
      .compact
  end
end
