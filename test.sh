#!/bin/bash
set -e
function del_vport {
	echo 'cleanup vport...'
}

trap del_vport EXIT

echo 'testing....'
fdsafasd

