module semvut

import semver { Increment, Version }

#include <stdlib.h>
#include <errno.h>

fn C.strtoul(charptr, &charptr, int) u32

pub fn next_prerelease(ver Version, pre_id string) Version {
	mut patch := ver.patch
	prerelease := if ver.prerelease.len > 0 {
		dot, pre_num := parse_prerelease(ver.prerelease)
		if pre_num >= 0 {
			'${ver.prerelease[0..dot + 1]}${pre_num + 1}'
		} else {
			'${ver.prerelease}.1'
		}
	} else {
		patch++
		'${pre_id}.0'
	}
	return Version{ver.major, ver.minor, patch, prerelease, ver.metadata}
}

pub fn next_release(ver Version, inc Increment) Version {
	return if ver.prerelease.len > 0 {
		mut next := Version{ver.major, ver.minor, ver.patch, '', ver.metadata}
		if inc == Increment.patch {
			next
		} else {
			next.increment(inc)
		}
	} else {
		ver.increment(inc)
	}
}

fn parse_prerelease(prerelease string) (int, int) {
	dot := prerelease.last_index_u8(`.`)
	return if dot < 0 {
		-1, -1
	} else if dot == prerelease.len - 1 {
		dot, 0
	} else {
		dot, parse_number(prerelease, dot + 1)
	}
}

fn parse_number(s string, from int) int {
	end := unsafe { nil }
	C.errno = 0
	n := C.strtoul(unsafe { s.str + from }, &end, 10)
	return if C.errno == 0 && unsafe { s.str + s.len } == end {
		int(n)
	} else {
		-1
	}
}
