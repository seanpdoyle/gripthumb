class AuddProxy < Rack::Proxy
  def perform_request(env)
    request = ActionDispatch::Request.new(env)

    env["HTTP_HOST"] = @backend.host
    env["PATH_INFO"] = "/"
    env["HTTP_COOKIE"] = ""

    request.delete_header "Accept"
    request.delete_header "X-CSRF-Token"

    request.request_parameters["api_token"] = api_token

    super(request.env)
  end

  private

  def api_token
    Rails.application.credentials.audd!.fetch(:api_token)
  end
end
