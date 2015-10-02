import os
import logging

import openerp
from openerp import http, SUPERUSER_ID
from openerp.http import request
from openerp.osv import fields, osv
from openerp.tools import config, appdirs

from openerp.addons.runbot.runbot import mkdirs, run, fqdn
_logger = logging.getLogger(__name__)


class runbot_repo(osv.osv):
    _inherit = "runbot.repo"

    def reload_nginx(self, cr, uid, context=None):
        """
        completely override the method
        """
        settings = {}
        settings['port'] = config['xmlrpc_port']
        nginx_dir = os.path.join(self.root(cr, uid), 'nginx')
        settings['nginx_dir'] = nginx_dir
        ids = self.search(cr, uid, [('nginx','=',True)], order='id')
        if ids:
            build_ids = self.pool['runbot.build'].search(cr, uid, [('repo_id','in',ids), ('state','=','running')])
            settings['builds'] = self.pool['runbot.build'].browse(cr, uid, build_ids)

            nginx_config = self.pool['ir.ui.view'].render(cr, uid, "runbot.nginx_config", settings)
            mkdirs([nginx_dir])
            open(os.path.join(nginx_dir, 'nginx.conf'),'w').write(nginx_config)
            _logger.debug('reload nginx')
            run(['sudo', '/bin/systemctl', 'reload', 'nginx'])

    def cron(self, cr, uid, ids=None, context=None):
        if fqdn() == 'runbot.odoo-communty.org':
            # phase out builds on main server
            return
        return super(runbot_repo, self).cron(cr, uid, ids, context=context)

    def pg_createdb(self, cr, uid, dbname):
        self.pg_dropdb(cr, uid, dbname)
        _logger.debug("createdb %s", dbname)
        cmd = ['createdb', '--encoding=unicode', '--lc-collate=C', '--template=template0', dbname]
        if config['db_user']:
            cmd += ['--username', config['db_user']]
        run(cmd)
