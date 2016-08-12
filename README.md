Papertrail
==========

[![](https://images.microbadger.com/badges/image/stevepacker/papertrail.svg)](https://microbadger.com/images/stevepacker/papertrail "Get your own image badge on microbadger.com")

This container image is intended to mount various log files or log directories to push new log entries
up to the [Papertrail](https://papertrailapp.com/?thank=e47d87) ([sans referral code](https://papertrailapp.com/)) log consolidation service.  It uses the open-source
[remote_syslog2](https://github.com/papertrail/remote_syslog2) library from Papertrail, so I imagine it
can be pushed to alternative locations as well.

Built using:
* [remote_syslog2](https://github.com/papertrail/remote_syslog2)
* [Alpine Linux](https://www.alpinelinux.org/)
* [Tini init system](https://github.com/krallin/tini)

Using IFTTT, this image will automatically build in the latest remote_syslog2.  This was done by:
# Activating the Docker Hub > Build Settings > Build Triggers
# Creating an IFTTT recipe using:
#* If there is a new RSS Feed item: https://github.com/papertrail/remote_syslog2/releases.atom
#* Use Maker channel to make a POST request to the Docker Hub Build Trigger

Untested, but hopeful.
