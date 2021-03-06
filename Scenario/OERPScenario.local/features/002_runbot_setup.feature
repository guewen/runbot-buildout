@config @setup @runbot

Feature: configure the runbot

  Scenario Outline: configure runbot options
    Given I need a "ir.config_parameter" with key: <key>
    And having:
      | key   | value   |
      | value | <value> |

    Examples: parameters
      | key                  | value                 |
      | runbot.running_max   | 20                    |
      | runbot.domain        | runbot.infra.internal |
      | runbot.timeout       | 1800                  |
      | runbot.starting_port | 2000                  |

  Scenario: setup repo for OCB
  Given I need a "runbot.repo" with name: https://github.com/OCA/OCB
  And having:
  | name         | value                             |
  | name         | https://github.com/OCA/OCB        |
  | testing      | 0                                 |
  | running      | 0                                 |
  | nginx        | 1                                 |
  | auto         | 0                                 |
  | modules_auto | repo                              |
  | group_ids    | by oid: runbot.group_runbot_admin |

  Scenario Outline: setup the project repositories
    Given I need a "runbot.repo" with oid: scenario.runbot_repo_<repo_name>
    And having
    | key                  | value                                                                               |
    | name                 | git@github.com:camptocamp/<repo_name>.git                                                |
    | testing              | 1                                                                                   |
    | running              | 1                                                                                   |
    | auto                 | 1                                                                                   |
    | nginx                | 1                                                                                   |
    | modules              | sale                                                                                |
    | is_custom_build      | 1                                                                                   |
    | skip_test_jobs       | 1                                                                                   |
    | custom_pre_build_cmd | ./runbot/prebuild.sh %(other_repo_path)s openerp:options.db_name=%(build_dest)s-all openerp:options.dbfilter=%(build_dest)s-all openerp:options.db_user=openerp_internal_runbot |
    | custom_server_params | --workers=0                                                                         |
    | custom_server_path   | bin/start_openerp                                                                   |
    | modules_auto         | repo                                                                                |
    | dependency_ids       | by name: https://github.com/OCA/OCB                                                 |
    | other_repo_id        | by name: https://github.com/OCA/OCB                                                 |

    Examples:
    | repo_name           |
    | mid_odoo            |
