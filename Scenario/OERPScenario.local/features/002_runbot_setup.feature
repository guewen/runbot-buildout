@config @setup @runbot

Feature: configure the runbot
  Scenario: setup repo for OCB
  Given I need a "runbot.repo" with name: https://github.com/OCA/OCB
  And having:
  | name    |                      value |
  | name    | https://github.com/OCA/OCB |
  | testing |                          1 |
  | running |                          1 |
  | nginx   |                          1 |
  | auto    |                          1 |

  Scenario Outline: setup the repositories
    Given I need a "runbot.repo" with name: https://github.com/camptocamp/<name>
    And having
    | name           | value                                |
    | name           | https://github.com/camptocamp/<name> |
    | testing        | 1                                    |
    | running        | 1                                    |
    | auto           | 1                                    |
    | nginx          | 1                                    |
    | dependency_ids | by name: https://github.com/OCA/OCB  |

    Examples:
    | name                |
    | mid_odoo            |
