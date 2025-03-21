// Small script used to calculate the matrix of builds that are going to be
// done if CI decides to do a release build.
//
// This is a separate script primarily to write out all the release
// targets/platforms once and then duplicate them all with a "min" build.

const array = [
  {
    // The name of the build which shows up in the name of the artifact for
    // Wasmtime's github releases.
    "build": "x86_64-linux",
    // The GitHub Actions platform that this build runs on
    "os": "ubuntu-22.04",
    // The Rust target that will be used for the build.
    "target": "x86_64-unknown-linux-gnu",
  },
  {
    "build": "aarch64-linux",
    "os": "ubuntu-22.04",
    "target": "aarch64-unknown-linux-gnu",
  },
  {
    "build": "s390x-linux",
    "os": "ubuntu-22.04",
    "target": "s390x-unknown-linux-gnu",
  },
  {
    "build": "riscv64gc-linux",
    "os": "ubuntu-22.04",
    "target": "riscv64gc-unknown-linux-gnu",
  },
  {
    "build": "x86_64-macos",
    "os": "macos-15",
    "target": "x86_64-apple-darwin",
  },
  {
    "build": "aarch64-macos",
    "os": "macos-15",
    "target": "aarch64-apple-darwin",
  },
  {
    "build": "x86_64-windows",
    "os": "windows-2022",
    "target": "x86_64-pc-windows-msvc",
  },
  {
    "build": "x86_64-mingw",
    "os": "windows-2022",
    "target": "x86_64-pc-windows-gnu",
  },
  {
    "build": "aarch64-android",
    "os": "ubuntu-22.04",
    "target": "aarch64-linux-android",
  },
  {
    "build": "x86_64-android",
    "os": "ubuntu-22.04",
    "target": "x86_64-linux-android",
  },
  {
    "build": "x86_64-musl",
    "os": "ubuntu-22.04",
    "target": "x86_64-unknown-linux-musl",
  },
];

const builds = [];
for (let build of array) {
  // Perform a "deep clone" roundtripping through JSON for a copy of the build
  // that's normal
  build.rust = 'default';
  builds.push(JSON.parse(JSON.stringify(build)));

  // Next generate a "min" build and add it to the builds list. Min builds
  // require Nightly rust due to some nightly build options that are configured.
  build.build += '-min';
  build.rust = 'wasmtime-ci-pinned-nightly';
  builds.push(build);
}

console.log(JSON.stringify(builds));
