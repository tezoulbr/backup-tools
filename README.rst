==============
 backup-tools
==============

---------------------------------
simple system/user backup wrapper
---------------------------------

:Author: Blemjhoo Tezoulbr <tezoulbr@gmail.com>
:Date: 2014-06-05
:Copyright: Copyright (c) 2012-2014 Blemjhoo Tezoulbr. Licensed under GPLv3+.
:Version: 13a
:Manual section: 1
:Manual group: backup

SYNOPSIS
========

backup-tools    [-h|--help] [--version] [--init] [--cron] [-d|--daily] 
        [--w|--weekly] [-m|--monthly] [-n|--manual] [-s|--sync]
        [-c|--custom] [-a|--all] [-i|--ignore] [--skip] [--verbose]
             

DESCRIPTION
===========

``backup-tools`` is not a backup program itself, it's a wrapper
designed to eliminate ugly backup scripts with duplicated functionality
and keep all the stuff in one nice config (and all the logs in one big
log). Also there are some side effects: easy logging, email reports,
visual notifications etc.

You still need program like ``rsync`` or ``tar`` (or something else) to
do all the dirty backup work.

``backup-tools`` can be used in two modes: user and system (as root).
In user mode it reads config from ``~/.backup-tools.conf`` and writes 
log to ``~/.backup-tools.log``. In system mode config is 
``/etc/backup-tools.conf`` and log is ``/var/log/backup-tools.log``.

To quickly setup ``backup-tools``, try ``--init`` switch. It will copy 
sample config to your home directory (or to ``/etc`` for root). It's 
well commented and is a good point to start.

There are six tasks: four backup-related (*daily*, *weekly*, *monthly* 
and *manual*), one *sync* task and one *custom* task. Also there are
*initialize*  and *finalize* events. Of course task names are just
convention.

You can call any number of tasks at once (for example, for initial 
backup or for backup + sync). If error was occured in task, all other
tasks are skipped (except finalize). Use ``--ignore`` switch
to to ignore task errors and continue. Note that ignore option does 
not ignore errors in *initialize* event. If it reports an error, this
is the end of the world.

Tasks are always executing in following order if multiple tasks are
specified:

* *initialize* event
* *daily*
* *weekly*
* *monthly*
* *manual*
* *sync*
* *custom*
* *finalize* event

*Initialize* and *finalize* events are executed at script start and end,
not around each task. If you want to do so, run ``backup-tools`` 
separately for each task. Both events can be disabled by ``--skip`` 
switch.

Crontab events for main tasks can be created automatically (try 
``--cron``  switch). *Daily*, *weekly* and *monthly* tasks have obvious 
schedule, while *sync* is executed weekly. Use ``crontab -e`` to 
adjust.

Both users and system logs are rotated by ``logrotate`` using
``/etc/logrotate.d/backup-tools`` scheme.

EXIT CODES
==========

* *0*	no error
* *1*	generic error (i.e. during task execution)
* *2*	another instance is already running
* *3*	SIGINT or SIGTERM received

OPTIONS
=======

-h, --help              Show help message and exit.
--version               Show version number and exit.
--init                  Create default config if not exists.
--cron                  Create cron jobs for current user.
-d, --daily             Execute *daily* backup task.
-w, --weekly            Execute *weekly* backup task.
-m, --monthly           Execute *monthly* backup task.
-n, --manual            Execute *manual* backup task.
-s, --sync              Execute *sync* task.
-c, --custom            Execute *custom* task.
-a, --all               Execute all tasks.
-i, --ignore            Ignore errors (except in *initialize* event).
--skip                  Skip *initialize*/*finalize* events.
-v, --verbose           Produce more entropy.

SEE ALSO
========

rsync(1), crontab(1), cron(8), logrotate(8), bash(1), tar(1)

NOTES
=====

``backup-tools`` homepage: https://github.com/tezoulbr/backup-tools
