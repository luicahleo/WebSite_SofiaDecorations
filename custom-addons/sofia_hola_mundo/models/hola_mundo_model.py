from odoo import models, fields, api


class HolaMundo(models.Model):
    """Modelo de demostración con validación estática (Type Hints)"""

    _name = "sofia.hola.mundo"
    _description = "Modelo Hola Mundo"

    name: str = fields.Char(string="Nombre", required=True)
    mensaje: str = fields.Text(string="Mensaje", default="¡Hola Mundo desde Odoo!")
    activo: bool = fields.Boolean(string="Activo", default=True)
    fecha_creacion = fields.Datetime(string="Fecha de Creación", default=fields.Datetime.now)

    def action_saludo(self) -> bool:
        """Acción que imprime un saludo en los logs.

        Equivalent to a method in C# that prints a greeting.

        Returns:
            bool: Always True after execution
        """
        for record in self:
            self._log_saludo(record.mensaje)
        return True

    def _log_saludo(self, mensaje: str) -> None:
        """Log a greeting message.

        Args:
            mensaje: The message to log
        """
        print(f"🎉 ¡Hola Mundo! Mensaje: {mensaje}")

    @api.constrains("name")
    def _validar_nombre(self) -> None:
        """Validar que el nombre no esté vacío.

        Like validation in C# with constraints.
        """
        for record in self:
            if not record.name or len(record.name.strip()) == 0:
                raise ValueError("El nombre no puede estar vacío")
