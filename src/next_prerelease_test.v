module semvut

import semver { Version }

fn test_from_stable() {
	ver := Version{1, 0, 0, '', ''}
	next := next_prerelease(ver, 'next')
	assert next.str() == '1.0.1-next.0'
}

fn test_from_unnumbered_prerelease() {
	ver := Version{1, 0, 0, 'alpha', ''}
	next := next_prerelease(ver, 'next')
	assert next.str() == '1.0.0-alpha.1'
}

fn test_from_prerelease_ending_with_dot() {
	ver := Version{1, 0, 0, 'alpha.', ''}
	next := next_prerelease(ver, '')
	assert next.str() == '1.0.0-alpha.1'
}

fn test_from_prerelease_including_dot() {
	ver := Version{1, 0, 0, 'alpha.test', ''}
	next := next_prerelease(ver, '')
	assert next.str() == '1.0.0-alpha.test.1'
}

fn test_from_numbered_prerelease() {
	ver := Version{1, 0, 1, 'beta.1', ''}
	next := next_prerelease(ver, '')
	assert next.str() == '1.0.1-beta.2'
}
