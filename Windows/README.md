# GNUKhata windows installer
=============================

The windows installer of GNUKhata is created with the software called [Inno Setup](https://jrsoftware.org/isinfo.php). It 
uses a permissive custom [license](https://github.com/jrsoftware/issrc/blob/main/license.txt) and is open source. Inno setup 
takes the files required by gnukhata along with a bunch of batch scripts to automate its execution and combines them into an 
easy to install .exe.

_Note:_ Online tutorials of Innosetup usually use .exe files, but it also works fine with batch files. We have not converted our batch files 
into .exe files here, as .exe files resulting from such a process is being flagged as virus by Windows Defender.

### Folder Structure
====================

The existing Innosetup file, assumes the following folder structure. Please update the Innosetup file based on your folder structure when working
on the installer (the same folder structure is not mandatory).
```
master_folder
	| All batch files, icon, license file and a .vbs file
	| gkcore
	| gkwebapp
	| dependencies
		| nginx
		| 32bit
			| pgsql
			| pip_dependencies
			| python_installer.exe
			| visual_cpp_installer.exe
		| 64bit
			| pgsql
			| pip_dependencies
			| python_installer.exe
			| visual_cpp_installer.exe
```		

### Dependencies
================

GNUKhata is built using several open source software and libraries. They are Python, PostgresQL, Visual C++ (dependency of PostgrsQL), Nginx 
and the pip dependencies for Gkcore and GkWebapp.

To provide an offline installer, all these dependencies have to be packaged along with the installer. An online installer on the other hand
can install the pip dependencies alone from internet and the other dependencies have to be packaged with the installer.

Detailed instructions about the dependencies can be found in [Dependency.md](https://gitlab.com/gnukhata/build/-/blob/master/Windows/Dependency.md) file.

**Points to remember:**
1. Depending upon the target machine architecture (32bit, 64bit, ARM), appropriate versions of the dependencies (Python, PostgresQL and Visual C++)
must be used.
2. Both Python and PostgresQL are available as pre compiled binaries (light weight, hard to configure) and installers (heavy, easy to use). 
Based on our comfort we have used Python's installer and PostgresQL's pre compiled binaries here.


