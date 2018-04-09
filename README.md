The guest machine entered an invalid state while waiting for it
to boot. Valid states are 'starting, running'. The machine is in the
'unknown' state. Please verify everything is configured
properly and try again.

If the provider you're using has a GUI that comes with it,
it is often helpful to open that and watch the machine, since the
GUI often has more helpful error messages than Vagrant can retrieve.
For example, if you're using VirtualBox, run `vagrant up` while the
VirtualBox GUI is open.

The primary issue for this error is that the provider you're using
is not properly configured. This is very rarely a Vagrant issue.



# todo

1. requrement.txt
2. swap