#!C:\gnukhatav7.0\WPy64-3830\python-3.8.3.amd64\python.exe
# EASY-INSTALL-ENTRY-SCRIPT: 'setuptools','console_scripts','easy_install-3.8'
__requires__ = 'setuptools'
import re
import sys
from pkg_resources import load_entry_point

if __name__ == '__main__':
    sys.argv[0] = re.sub(r'(-script\.pyw?|\.exe)?$', '', sys.argv[0])
    sys.exit(
        load_entry_point('setuptools', 'console_scripts', 'easy_install-3.8')()
    )
