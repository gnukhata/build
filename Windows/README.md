# GNUKhata windows installer
=============================

The windows installer of GNUKhata is created with the software called [Inno Setup](https://jrsoftware.org/isinfo.php). It 
uses a permissive custom [license](https://github.com/jrsoftware/issrc/blob/main/license.txt) and is open source. Inno setup 
takes the files required by gnukhata along with a bunch of batch scripts to automate its execution and combines them into an 
easy to install .exe.

_Note:_ Online tutorials of Innosetup usually use .exe files, but it also works fine with batch files. We have not converted the batch files 
into .exe files here, as .exe files resulting from such a process is being flagged as virus by Windows Defender.

### Dependencies: 
================

GNUKhata is built using several open source softwares and libraries. They are Python, PostgresQL, Visual C++ (dependency of PostgrsQL) 
and the pip dependencies for Gkcore and GkWebapp.

To provide an offline installer all these dependencies have to be packaged along with the installer. An online installer on the other hand
requires only Python, PostgresQL and Visual C++ to be packaged, the pip dependencies can be installed from the internet.

**Points to remember:**
1. Depending upon the target machine architecture (32bit, 64bit, ARM), appropriate versions of the dependencies (Python, PostgresQL and Visual C++)
must be used.
2. Both Python and PostgresQL are available as pre compiled binaries (light weight, hard to configure) and installers (heavy, easy to use). 
Based on our comfort we have used Python's installer and PostgresQL's pre compiled binaries here.