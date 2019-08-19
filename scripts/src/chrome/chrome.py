#!/usr/bin/env python3

from syspy import Shell, getInputs, error

sh = Shell()

inputs = getInputs()

if len(inputs) > 1: error('cannot handle plural inputs')

url = ''
try: url = inputs[0]
except: pass

sh.chrome(url)