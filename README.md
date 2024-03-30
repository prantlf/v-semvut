# SemVer Utilities for V

Additional functions for working with semantic versions, for example with pre-releases.

## Synopsis

```v
import semver { build }
import prantlf.semvut { next_prerelease, next_release }

ver := build('1.0.0')!

pre1 := next_prerelease(ver, 'next') // 1.0.0 --> 1.0.1-next.0
pre2 := next_prerelease(pre1, '')    // 1.0.1-next.0 --> 1.0.1-next.1

next := next_release(ver, Increment.patch)  // 1.0.0 --> 1.0.1
next := next_release(pre2, Increment.patch) // 1.0.1-next.1 --> 1.0.1
next := next_release(pre2, Increment.minor) // 1.0.1-next.1 --> 1.1.0
```

## Installation

You can install this package either from [VPM] or from GitHub:

```txt
v install prantlf.semvut
v install --git https://github.com/prantlf/v-semvut
```

## API

The following functions are exported:

### next_prerelease(ver Version, pre_id string) Version

Returns the next pre-release version for the input version. If the input version isn't a pre-release, the pre-release id will be used, otherwise it'll be ignored.

If the input version is a stable release, the pre-release will be computed by bumping the patch version and by appending the pre-release id an a pre-release number 0:

    next_prerelease(Version{ 1, 0, 0 }, 'next') // 1.0.0 --> 1.0.1-next.0

If the input version is a pre-release with no pre-release number, the next pre-release will be computed by appending the a pre-release number 1:

    next_prerelease(Version{ 1, 0, 0, 'next' }, '') // 1.0.0-next --> 1.0.0-next.1

If the input version is a pre-release with a pre-release number, the next pre-release will be computed by bumping the  pre-release number:

    next_prerelease(Version{ 1, 0, 0, 'next.2' }, '') // 1.0.0-next --> 1.0.0-next.2

Example:

```go
import semver { build }
import prantlf.semvut { next_prerelease }

ver := build('1.0.0')!
pre := next_prerelease(ver, 'next') // 1.0.0 --> 1.0.1-next.0
```

### next_release(ver Version, inc Increment) Version

Returns the next stable release version for the input version.

If the input version is a stable release, the next release will be computed by incrementing the according version:

    next_release(Version{ 1, 0, 0 }, Increment.patch) // 1.0.0 --> 1.0.1
    next_release(Version{ 1, 0, 0 }, Increment.minor) // 1.0.0 --> 1.1.0
    next_release(Version{ 1, 0, 0 }, Increment.major) // 1.0.0 --> 2.0.0

If the input version is a pre-release number, the next release will be computed by removing the pre-release id and bumping the version depending on the increment. If the increment is `patch`, the version numbers will be kept:

    next_release(Version{ 1, 0, 0, 'next.0' }, Increment.patch) // 1.0.0-next.0 --> 1.0.0
    next_release(Version{ 1, 0, 0, 'next.0' }, Increment.minor) // 1.0.0-next.0 --> 1.1.0
    next_release(Version{ 1, 0, 0, 'next.0' }, Increment.major) // 1.0.0-next.0 --> 2.0.0

Example:

```go
import semver { Increment, build }
import prantlf.semvut { next_release }

ver := build('1.0.0-next.0')!
pre := next_release(ver, Increment.patch) // 1.0.0-next.0 --> 1.0.0
```

## Contributing

In lieu of a formal styleguide, take care to maintain the existing coding style. Lint and test your code.

## License

Copyright (c) 2024 Ferdinand Prantl

Licensed under the MIT license.

[VPM]: https://vpm.vlang.io/packages/prantlf.semvut
