{
    'name': 'Sofia Decorations - Base',
    'version': '17.0.1.0.0',
    'category': 'Custom',
    'summary': 'Módulo base para Sofia Decorations',
    'description': '''
        Módulo base que contiene configuraciones y funcionalidades
        comunes para toda la aplicación Sofia Decorations.
    ''',
    'author': 'Sofia Decorations Development Team',
    'website': 'https://sofiadecoraciones.com',
    'license': 'LGPL-3',
    'depends': [
        'base',
        'sale',
        'stock',
        'account',
    ],
    'data': [
        'views/menu_views.xml',
    ],
    'demo': [],
    'installable': True,
    'auto_install': False,
    'application': False,
}
