#!/bin/bash

function x() {
  echo "Hello world:$1"
}

function around() {
	echo "before"
	func=($1)
	${func} HERE
	echo "after"
}

around x
