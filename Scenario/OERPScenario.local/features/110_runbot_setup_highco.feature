@highco @config @setup @runbot

Feature: configure the runbot for the highco project.
  This project has not the typical structure, it only contains
  addons, with a buildout.cfg file which is there for devs.

  Scenario: setup the highco project repository
    Given I need a "runbot.repo" with oid: scenario.runbot_repo_highco_odoo
    And having
    | key                  | value                                                                               |
    | name                 | git@github.com:camptocamp/highco_odoo.git                                                |
    | testing              | 1                                                                                   |
    | running              | 1                                                                                   |
    | auto                 | 1                                                                                   |
    | nginx                | 1                                                                                   |
    | modules              | sale                                                                                |
    | is_custom_build      | 1                                                                                   |
    | skip_test_jobs       | 1                                                                                   |
    | custom_pre_build_cmd | ./.runbot_install.sh %(other_repo_path)s openerp:options.db_name=%(build_dest)s-all openerp:options.dbfilter=%(build_dest)s-all openerp:options.db_user=openerp_internal_runbot |
    | custom_server_params | --workers=0                                                                         |
    | custom_server_path   | bin/start_openerp                                                                   |
    | modules_auto         | repo                                                                                |
    | dependency_ids       | by name: https://github.com/OCA/OCB                                                 |
    | other_repo_id        | by name: https://github.com/OCA/OCB                                                 |
