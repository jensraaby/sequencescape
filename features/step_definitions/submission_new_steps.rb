TEST_TEMPLATE_NAME = "Pulldown library creation - Single ended sequencing"
TEST_TEMPLATE_DEFAULTS = {
  "submission_order_params_fragment_size_required_from" => 100,
  "submission_order_params_fragment_size_required_to" => 200,
  "submission_order_params_library_type" => "Standard",
  "submission_order_params_read_length" => "37"
}

def choose_template_and_select_parameters
  page.select TEST_TEMPLATE_NAME, :from => 'submission_template_id'
  @submission_template = SubmissionTemplate.find(:first, :conditions => {:name => TEST_TEMPLATE_NAME})
  TEST_TEMPLATE_DEFAULTS.each do |field, value|
    fill_in(field, :with => value)
  end
end

Given /^I am ready to add orders$/ do
  choose_template_and_select_parameters
  page.has_button?('add_order')
end

Given /^I have set the order parameters using an asset group$/ do
  pending # express the regexp above with the code you wish you had
end

Given /^I have saved the order$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^I should be able to build the submission$/ do
  pending # express the regexp above with the code you wish you had
end

Given /^I have chosen a Study$/ do
  pending # express the regexp above with the code you wish you had
end

When /^I select the samples$/ do
  pending # express the regexp above with the code you wish you had
end

When /^I choose the project$/ do
  pending # express the regexp above with the code you wish you had
end
