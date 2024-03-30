module semvut

import semver { Increment, Version }

fn test_from_stable() {
	ver := Version{1, 0, 0, '', ''}
	next := next_release(ver, Increment.patch)
	assert next.str() == '1.0.1'
}

fn test_patch_from_prerelease() {
	ver := Version{1, 0, 0, 'next', ''}
	next := next_release(ver, Increment.patch)
	assert next.str() == '1.0.0'
}

fn test_minor_from_prerelease() {
	ver := Version{1, 0, 0, 'next', ''}
	next := next_release(ver, Increment.minor)
	assert next.str() == '1.1.0'
}

fn test_major_from_prerelease() {
	ver := Version{1, 0, 0, 'next', ''}
	next := next_release(ver, Increment.major)
	assert next.str() == '2.0.0'
}
