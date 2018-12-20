#!/bin/bash
vim='/usr/bin/vim'
scriptVim=$HOME'/Scripts/edit/scriptVim'

inputs="${@}"
${vim} <(${inputs}) -s ${scriptVim}
