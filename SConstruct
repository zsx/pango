# vim: ft=python expandtab
import os
import re
from site_init import GBuilder, Initialize

opts = Variables()
opts.Add(PathVariable('PREFIX', 'Installation prefix', os.path.expanduser('~/FOSS'), PathVariable.PathIsDirCreate))
opts.Add(BoolVariable('DEBUG', 'Build with Debugging information', 0))
opts.Add(PathVariable('PERL', 'Path to the executable perl', r'C:\Perl\bin\perl.exe', PathVariable.PathIsFile))
opts.Add(ListVariable("install", "targets to install", ["run,dev"], ['run', 'dev']))
opts.Add(BoolVariable('WITH_OSMSVCRT', 'Link with the os supplied msvcrt.dll instead of the one supplied by the compiler (msvcr90.dll, for instance)', 0))

env = Environment(variables = opts,
                  ENV=os.environ, tools = ['default', 'packaging', GBuilder])

Initialize(env)
env.Append(CPPPATH=['#'])
env.Append(CFLAGS=env['DEBUG_CFLAGS'])
env.Append(CPPDEFINES= env['DEBUG_CPPDEFINES'])

if env['WITH_OSMSVCRT']:
    env['LIB_SUFFIX'] = '-0'

PANGO_VERSION_MAJOR=1
PANGO_VERSION_MINOR=27
PANGO_VERSION_MICRO=1
env['PANGO_VERSION'] = '%d.%d.%d' % (PANGO_VERSION_MAJOR, PANGO_VERSION_MINOR, PANGO_VERSION_MICRO)
PANGO_API_VERSION = '1.0'
PANGO_BINARY_AGE = 100 * PANGO_VERSION_MINOR + PANGO_VERSION_MICRO
if PANGO_VERSION_MINOR % 2 == 0:
    PANGO_INTERFACE_AGE = 0 #unstable releases
else:
    PANGO_INTERFACE_AGE = PANGO_VERSION_MICRO #stable releases
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
                      '@WIN32_LIBS@': '-lgdi32',
                      '@PKGCONFIG_CAIRO_REQUIRES@': 'pangoft2 pangowin32'
                      }
env.DotIn('config.h', 'config.h.in')
env.DotIn('pango.pc', 'pango.pc.in')
env.DotIn('pangowin32.pc', 'pangowin32.pc.in')
env.DotIn('pangocairo.pc', 'pangocairo.pc.in')
env.DotIn('pangoft2.pc', 'pangoft2.pc.in')
env.DotIn('pangoxft.pc', 'pangoxft.pc.in')
print "Install = ", env['install']
if 'dev' in env['install']:
    env.Alias('install', env.Install('C:/lib/pkgconfig', ['pango.pc', 'pangowin32.pc', 'pangocairo.pc', 'pangoft2.pc', 'pangoxft.pc']))

subs = ['pango/SConscript',
        'pango-view/SConscript']

if ARGUMENTS.get('build_test', 0):
    subs += ['tests/SConscript']

SConscript(subs, exports = 'env')

if 'run' in env['install'] and \
        'dev' in env['install']:
    package_name = 'pango'
elif 'run' in env['install']:
    package_name = 'pango-runtime'
elif 'dev' in env['install']:
    package_name = 'pango-dev'

env.Package(NAME            = package_name,
            VERSION         = env['PANGO_VERSION'] + '.0',
            PACKAGEVERSION  = 0,
            PACKAGETYPE     = 'zip'
            )
