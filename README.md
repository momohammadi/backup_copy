# Backup Copy
Copies the source directory or file(s) to the destination, also retries once for unsuccessful items, and finally sends a notification with a full report that can contain the path of successfully and/or unsuccessfully copied files.
My goal is to add more destinations type and types of notification channels in future versions.
### current support destination: 
ftp
### current support notification channel: 
email
## Getting started
first clone this repo 
```
git clone https://github.com/momohammadi/backup_copy.git
cd backup_copy
cp config/default.simple.cnf config/default.cnf
sh setup.sh
```
after that open `config/default.cnf` file with desired editor and filled it out.

note: each item on this file has description

finally you can use `bash backup_copy.sh` or `./backup_copy.sh` for copy source to destination
#### testing
using `--dry-run` or enable `DRY_RUN` in config file to see output without copy anything.

## Automation 
pure mode:

first set `QUIET` to `true` in config file then add `./PATH/TO/backup_copy.sh` to cronjob.
e.x:
```
0 */12 * * * ./PATH/TO/backup_copy.sh > /dev/null 2>&1
```

use with software hook bellow example is for CPanel post backup hook
```
/usr/local/cpanel/bin/manage_hooks add script /PATH/TO/backup_copy.sh --manual --category System --event Backup --stage=post
```
every time a WHM backup job has been finished the backup copy script runs and does what you setting up on it