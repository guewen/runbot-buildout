@setup @runbot
Feature: install the required modules

Scenario: install modules
  Given I install the required modules with dependencies:
  | name                      |
  | runbot_secure             |
  | runbot_build_instructions |
  | runbot_skip_tests         |
