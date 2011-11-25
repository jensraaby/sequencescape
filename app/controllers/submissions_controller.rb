class SubmissionPresenter
  ATTRIBUTES = [ :template_id, :study_name, :project_name, :comments ]

  attr_accessor *ATTRIBUTES

  def initialize(user, submission_attributes = {})
    @user = user

    ATTRIBUTES.each do |attribute|
      send("#{attribute}=", submission_attributes[attribute])
    end

  end

  def build_submission!
    raise "NOT IMPLEMENTED YET"
  end

  # These parameters should be defined by the submission template (to be renamed
  # order template) the old view code gets them by generating a new instance of
  # Order and then calling Order#input_field_infos.  This is a wrapper around
  # until I can refactor it out.
  def order_parameters
    order.input_field_infos
  end

  def order
    @order ||= template.new_order
  end

  def project
    @project ||= Project.find_by_name(@project_name)
  end

  # Creates a new submission and adds an initial order on the submission using
  # the parameters
  def save!
    ActiveRecord::Base.transaction do
      raise "NOT IMPLEMENTED YET"
    end
  end

  def study
    @study ||= Study.find_by_name(@study_name)
  end

  # Returns an array of the names of all the non-inactive studies
  # TODO[sd9] filter this via the database rather than in memory
  def studies
    @studies ||= Study.all.reject(&:inactive?).map(&:name)
  end

  # Returns the SubmissionTemplate (OrderTemplate) to be used for this Submission.
  def template
    @template ||= SubmissionTemplate.find(@template_id)
  end

  def templates
    @templates ||= SubmissionTemplate.all
  end

  # Returns an array of all the names of studies associated with the current
  # user.
  def user_projects
    @user_projects ||= @user.sorted_project_names_and_ids.map(&:first)
  end
end




class SubmissionsController < ApplicationController

  def new
    @submission_presenter = SubmissionPresenter.new(current_user)
  end

  def create
    @submission_presenter = SubmissionPresenter.new(current_user, params[:submission])
    debugger

    @submission_presenter.save!

  end

  # TODO[sd9]: Move this to a separate name spaced controller
  def order_parameters
    @submission_presenter = SubmissionPresenter.new(current_user, params[:submission])

    render :partial => 'order_parameters', :layout => false
  end

  def study_assets
    @submission_presenter = SubmissionPresenter.new(current_user, params[:submission])

    render :partial => 'study_assets', :layout => false
  end
end

