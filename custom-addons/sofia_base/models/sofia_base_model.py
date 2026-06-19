from odoo import models, fields


class SofiaBaseConfig(models.Model):
    _name = "sofia.base.config"
    _description = "Sofia Decorations Configuration"

    name = fields.Char(string="Configuration Name", required=True)
    company_id = fields.Many2one("res.company", string="Company", required=True)
    is_active = fields.Boolean(string="Active", default=True)

    def _name_get(self):
        return [(record.id, record.name) for record in self]
