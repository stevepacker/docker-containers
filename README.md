PPTPD Server
============

There are a number of other PPTPD container images, but this one differs by
allowing usernames and passwords be defined by ENV variables.

## Env:

*USERNAMES* is a comma-separated list of usernames.  Since it's comma-separated, usernames cannot contain commas.
*PASSWORDS* is a comma-separated list of passwords.  Since it's comma-separated, passwords cannot contain commas, and cannot end in a space.

## Example:

`docker run -d --name=pptpd --privileged --restart=always -p 1723:1723 -e USERNAMES=alice,bob,carl -e PASSWORDS=g00dPa55worD,deadBeef,god stevepacker/pptpd`

Note:

* --privileged is required for networking manipulation
* Alice's password is: g00dPa55worD
* Bob's   password is: deadBeef
* Carl's  password is: god (shame on him!)

