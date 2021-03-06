# -*- coding: utf-8 -*-

from time import time
import dns.resolver
import dns.exception

class Py3status:
    """
    Configuration parameters:

        format: the format (including 'egress')
        color: color to be used
        cached_timeout: ...
    """

    format = 'Egress: {egress}'
    color = '000000'
    cached_timeout = 60

    def egress(self, output, config):
        resolver = dns.resolver.Resolver()
        # resolver1.opendns.com
        resolver.nameservers = ['208.67.222.222']
        answer = ""

        try:
            answer = resolver.query('myip.opendns.com')[0]
        except dns.exception.Timeout:
            return {
                    'cached_until': time(),
                    'full_text': self.format.format(egress="n/a"),
                    'color': 'ff0000'
            }

        return {
                'cached_until': time() + self.cached_timeout,
                'full_text': self.format.format(egress=str(answer)),
                'color': self.color
                }

if __name__ == '__main__':
    '''
    Test this module by calling it directly.
    '''
    from time import sleep
    x = Py3status()

    config = {
            format: 'E: {egress}'
            }
    while True:
        print(x.egress([], config))
        sleep(1)
