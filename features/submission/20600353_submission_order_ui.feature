@submission @new_submission
Feature: Submission and Order Creation
	As a Project Manager I want to be able to create a submission from a Study, a Project and some Assets,
	adding orders to the Submission before submitting it.

	Background:
		Given I am an "administrator" user logged in as "John Smith"
		And I am on the Submissions Inbox page

	# Scenario: Finishing an already started Submission

  Scenario: Building a submission for a study
    Given I am on a study management page
      And I follow "new submission"
      Then I should be able to choose a submission template
    When I have chosen a submission template
      And I have filled in the template options
      Then I should see a blank order form
    When I have selected an asset group for the order
      And I have chosen a project with quota
      And I have saved the order
      Then I should be able to build the submission
    When I have built the submission
      Then I should see it in the study's submissions inbox

  Scenario: Adding an order to an already started submission
    Given I have started a submission
      Then I should see existing orders in the submission
      And I should be able to add an order
    When I have added a new order
      And I have saved the new order
      Then I should see it in the Submissions Inbox
      
  Scenario: Manually choosing assets for an order
    Given I have started a submission
      Then I should see a blank order form
    When I have typed in asset names for the order
      And I have chosen a project with quota
      And I have saved the order
      Then I should be able to build the submission
