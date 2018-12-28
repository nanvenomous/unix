#!/bin/bash

function x() {
  echo "Hello world:$1"
}

function around() {
	echo "before"
	here='HERE'
	func=($1)
	${func} ${here}
	echo "after"
}

around x
