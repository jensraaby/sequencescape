@javascript @submission
Feature: Submission creation with orders
  As a Project Manager I want to be able to create a submission from a Study, a Project and some Assets, 
  adding orders to the Submission before submitting it.
  
  Background:
    Given I am an "administrator" user logged in as "John Smith"
    And I am on the Submissions Inbox page
    And I follow "new Submission"
    
  @javascript
  Scenario: Building a submission with one order from an asset group
    Given I am ready to add orders
    Given  I have set the order parameters using an asset group
      And  I have saved the order
      Then I should be able to build the submission
      
  Scenario: Building a submission with one order with individual assets
    Given I am ready to add orders
      And I have chosen a Study
     When I select the samples
      And I choose the project
      And I have saved the order
     Then I should be able to build the submission
    