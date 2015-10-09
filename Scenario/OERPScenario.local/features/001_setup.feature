@setup @runbot
Feature: install the required modules

  @createdb @no_login
  Scenario: Create database
    Given I find or create database from config file

  Scenario: install modules
    Given I install the required modules with dependencies:
      | name                      |
      | runbot_secure             |
      | runbot_build_instructions |
      | runbot_skip_tests         |
      | runbot_camptocamp         |
