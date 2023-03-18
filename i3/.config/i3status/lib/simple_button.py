# -*- coding: utf-8 -*-
"""
Simple button
"""

from time import time


class Py3status:
    """
    Configuration parameters:

        text: what is displayed
        color: color used
    """
    # available configuration parameters
    text = "CHANGE_ME"
    color = "#00FF00"

    def output(self, i3s_output_list, i3s_config):
        response = {
            'cached_until': time() + 7200,
            'full_text': self.text,
            'color': self.color
        }

        return response


if __name__ == "__main__":
    """
    Test this module by calling it directly.
    """
    from time import sleep

    x = Py3status()
    config = {
        'text': "BLAH"
    }

    while True:
        print(x.output([], config))
        sleep(1)
