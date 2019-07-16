#!/bin/bash
vim='/usr/bin/vim'

inputs="${@}"
${vim} <(${inputs})
