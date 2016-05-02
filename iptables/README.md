# Usage

Install `iptables-persistent`. Then, 

```sh
$ cd /usr/local/bin
$ ln ~/PATH/TO/THIS/WORKING_COPY/bin/* .
$ cd /etc/network/if-pre-up.d
$ ln ~/PATH/TO/THIS/WORKING_COPY/etc/* .
```

And run `iptables.sh` once.
