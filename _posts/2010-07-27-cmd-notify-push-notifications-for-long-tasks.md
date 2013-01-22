---
layout: post
title: ! 'cmd-notify: Push notifications for long tasks'
tags:
- Programming
- Python
status: publish
type: post
published: true
meta:
  _edit_last: '1'
  _wp_old_slug: ''
---
I just started a new job, and as part of the induction we had to do a lot of complete builds, both for an application server and for a pretty substantial database. Needless to say, these took quite a long time.

I found myself wishing there was a way for the computer to notify me that it was done, so I could go elsewhere and do something interesting while it plodded along.

To this end, I wrote the following little python script, which uses [notifo](http://http://notifo.com/) to send you a push message on your iPhone when a command has finished executing.

{:lang="python"}
    #!/usr/bin/env python

    from notifo import Notifo
    import os, sys

    api_user = [API_USER]
    api_key = [API_KEY]
    notifo = Notifo(api_user, api_key)

    def print_usage():
        sys.stderr.write('''Usage:
        %(command)s register &lt;username>
        or
        %(command)s &lt;username> &lt;command>
        ''' % { 'command': sys.argv[0] })

    def register(username):
        result = notifo.subscribe_user(username)
        sys.stderr.write(result["response_message"] + '\n')

    def notify(username):
        result = notifo.send_notification(username, 'Command \'%s\' has completed' % command)
        if result['status'] == 'error':
            sys.stderr.write('cmd-notify error: ' + result["response_message"] + '\n')

    if len(sys.argv) == 3 and sys.argv[1] == 'register':
        username = sys.argv[2]
        register(username)
    elif len(sys.argv) < 4:
        print_usage()
    else:
        username = sys.argv[1]
        command = ' '.join(sys.argv[2:])
        os.system(command)
        notify(username)

First register your account to receive push notifications by running `cmdnotify.py register <username>`. Once you've accepted messages from the service, simply use `cmdnotify.py <username> <command>` (e.g. `cmdnotify.py ajanuary build_db $DB_NAME<`). When the command has finished, you'll get a push notification letting you know it's done.
