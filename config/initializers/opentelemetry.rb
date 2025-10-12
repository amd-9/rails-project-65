# frozen_string_literal: true

if Rails.env.production?
  require 'opentelemetry/sdk'
  require 'opentelemetry/exporter/otlp'
  require 'opentelemetry/instrumentation/all'
  OpenTelemetry::SDK.configure do |c|
    c.service_name = 'Awesome_Bulletins'
    c.use_all # enables all instrumentation!
  end
end
