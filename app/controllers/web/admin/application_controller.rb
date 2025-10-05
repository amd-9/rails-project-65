# frozen_string_literal: true

class Web::Admin::ApplicationController < Web::ApplicationController
  layout 'layouts/admin'

  before_action :authorize_admin

  def authorize_admin
    authorize :user, :admin?
  end
end
