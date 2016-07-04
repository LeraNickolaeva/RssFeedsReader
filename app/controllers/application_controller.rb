class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  unless Rails.application.config.consider_all_requests_local
    rescue_from Exception, with: :render_500
    rescue_from ActionController::RoutingError, with: :render_404
    rescue_from ActionController::UnknownController, with: :render_404
    rescue_from AbstractController::ActionNotFound, with: :render_404
    rescue_from ActiveRecord::RecordNotFound, with: :render_404
  end

  def render_500(exception = nil)
    render_exception(500, exception.message, exception)
  end


  def render_404(exception = nil)
    render_exception(404, 'Page not found', exception)
  end


  def render_exception(status = 500, message = 'Server error', exception)
    @status = status
    @message = message

    if exception
      Rails.logger.fatal "\n#{exception.class.to_s} (#{exception.message})"
      Rails.logger.fatal exception.backtrace.join("\n")
    else
      Rails.logger.fatal "No route matches [#{env['REQUEST_METHOD']}] #{env['PATH_INFO'].inspect}"
    end

    render template: "errors/error_404", formats: [:html], layout: 'application', status: @status
  end

end
