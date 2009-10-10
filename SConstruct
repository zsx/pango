# vim: ft=python expandtab
import os
import re
from site_init import GBuilder, Initialize

opts = Variables()
opts.Add(PathVariable('PREFIX', 'Installation prefix', os.path.expanduser('~/FOSS'), PathVariable.PathIsDirCreate))
opts.Add(BoolVariable('DEBUG', 'Build with Debugging information', 0))
opts.Add(PathVariable('PERL', 'Path to the executable perl', r'C:\Perl\bin\perl.exe', PathVariable.PathIsFile))

env = Environment(variables = opts,
                  ENV=os.environ, tools = ['default', GBuilder])

Initialize(env)
env.Append(CPPPATH=['#'])
env.Append(CFLAGS=env['DEBUG_CFLAGS'])
env.Append(CPPDEFINES=env['DEBUG_CPPDEFINES'])

PANGO_VERSION_MAJOR=1
PANGO_VERSION_MINOR=26
PANGO_VERSION_MICRO=0
env['PANGO_VERSION'] = '%d.%d.%d' % (PANGO_VERSION_MAJOR, PANGO_VERSION_MINOR, PANGO_VERSION_MICRO)
PANGO_API_VERSION = '1.0'
PANGO_BINARY_AGE = 100 * PANGO_VERSION_MINOR + PANGO_VERSION_MICRO
PANGO_INTERFACE_AGE = 0
PANGO_MODULE_VERSION =  '1.6.0'
env['DOT_IN_SUBS'] = {'@PANGO_VERSION_MAJOR@': str(PANGO_VERSION_MAJOR),
                      '@PANGO_VERSION_MINOR@': str(PANGO_VERSION_MINOR),
                      '@PANGO_VERSION_MICRO@': str(PANGO_VERSION_MICRO),
                      '@PANGO_API_VERSION@': str(PANGO_API_VERSION),
                      '@PANGO_BINARY_AGE@': str(PANGO_BINARY_AGE),
                      '@PANGO_INTERFACE_AGE@': str(PANGO_INTERFACE_AGE),
                      '@PANGO_MODULE_VERSION@': str(PANGO_MODULE_VERSION),
                      '@VERSION@': env['PANGO_VERSION'],
                      '@prefix@': env['PREFIX'],
                      '@exec_prefix@': '${prefix}/bin',
                      '@libdir@': '${prefix}/lib',
                      '@includedir@': '${prefix}/include',
                      '@WIN32_LIBS@': 'gdi32',
                      #'@PKGCONFIG_CAIRO_REQUIRES@': ''
                      }
env.DotIn('config.h', 'config.h.in')
env.DotIn('pango.pc', 'pango.pc.in')
env.DotIn('pangowin32.pc', 'pangowin32.pc.in')
env.DotIn('pangocairo.pc', 'pangocairo.pc.in')
env.DotIn('pangoft2.pc', 'pangoft2.pc.in')
env.DotIn('pangoxft.pc', 'pangoxft.pc.in')
env.Alias('install', env.Install('$PREFIX/lib/pkgconfig', ['pango.pc']))

SConscript(['pango/SConscript',
            'pango-view/SConscript'], exports = 'env')
