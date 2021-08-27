# GNUKhata Dependencies
=======================
* Common Dependencies
	1. Python 3.8
	2. PostgresQL 9.6
	3. Visual C++ 13
	4. Nginx 1.20.1
* Gkcore Dependencies (listed in gkcore repo)
	1. pyramid == 1.10.5
	2. psycopg2 == 2.9.1
	3. sqlalchemy == 1.3.20
	4. monthdelta == 0.9.1
	5. pyjwt == 1.7.1
	6. pycryptodome == 3.9.9
	7. supervisor == 4.2.1
	8. natsort == 7.1.0
	9. waitress == 1.4.4
	10. gunicorn==20.1.0 (not required for windows)
	11. pillow == 8.0.1
	12. requests == 2.25.0
	13. wsgicors == 0.7.0
	14. openpyxl == 2.5.0
* Gkwebapp Dependencies (listed in gkwebapp repo)
	1. pyramid == 1.10.5
	2. openpyxl == 2.5.0
	3. pyramid_jinja2 == 2.8
	4. WebOb == 1.8.6
	5. waitress == 1.4.4
	6. gunicorn == 20.1.0 (not required for windows)
	7. wsgicors == 0.7.0
	8. requests == 2.25.0
	9. Pillow == 8.0.1
	10. supervisor == 4.2.1
	11. Babel == 2.9.0

### Points to note
1. Except nginx and part of the pip_dependencies, all the other dependencies require separate
installer or code package depending upon the CPU architecture (32bit and 64bit). Download the
packages for the required architecture and use them accordingly while creating the installer.
2. The [folder structure](https://gitlab.com/gnukhata/build/-/blob/master/Windows/README.md#folder-structure) that has been used is present in the README.md file, please use it as a referrence
to structure your setup.
3. At the time of writing this file,
	* Gunicorn doesn't work on windows and hence we are using waitress
	to serve files in windows.
	* Nginx supports only one worker in windows, even though it allows
	creating more than one worker.

### Download resources
__Note: Please use these links as a referrence. With the ever changing web they may not work in the future and 
a security cautious developer would want to check their authenticity before downloading.__

1. Python (v3.8.10): https://www.python.org/downloads/release/python-3810/
	- We are using version 3.8.10 as it starts support from windows 7.

2. PostgresQL (v9.6.23): https://www.enterprisedb.com/download-postgresql-binaries
	- We are using pre compiled binaries here, as we can remove unwanted packages (pgadmin, stackbuilder) that come
	packaged along with pgsql.
	- Extract the contents of the zip file after download, remove the "pgadmin" and "stackbuilder" folders from the pgsql folder. 
	Add add a new empty folder called "pgadmin" (will be the storage destination of the DB).

3. VisualC++ (for visual studio 2013): https://www.microsoft.com/en-in/download/details.aspx?id=40784
	- Visuall C++ is a dependency for PostgresQL in windows.
	- We have chosen 2013 here as its hardware and software requirements are pretty low and it doesn't have any known security
	vulnerabilities. (2005 and 2008 download pages state they have vulnerabilities)

4. Nginx (v1.20.1): https://nginx.org/en/download.html
	- We have chosen the existing stable version of nginx as of writing this document.
	- After downloading it, extract it and add the nginx.conf file found in this repo, and paste it
	into the "conf" folder found in the nginx folder.

5. Pip Dependencies: Can be downloaded via pip directly.
	- If going for a complete offline installer, then pip dependencies have to packaged along with the above
	listed softwares.
	- Some pip dependencies offer both 32bit and 64 bit variants. 
	So use pip from python v3.8.10 64bit to download 64 bit dependencies and 
	the 32bit version of python to download the 32bit pip dependencies.
	- To download do the following once for 64 bit and again once for 32 bit (use as a reference only),
		```bat
			# Download Code
				mkdir pip_dependencies
				cd path/to/gkcore
				py -m pip download -r requirements.txt -d path/to/pip_dependencies
				# Make sure the contents of requirements.txt are the same as those in setup.py
				cd path/to/gkwebapp
				py -m pip download -r requirements.txt -d path/to/pip_dependencies
			#
			# To install from the folder pip_dependencies, run the following for gkcore and gkwebapp
			# This is the default installation mode currently and this code can be seen in init_gkcore.bat and init_gkwebapp.bat
				python.exe setup.py develop --always-unzip --allow-hosts=None --find-links=path\to\pip_dependencies
		```
