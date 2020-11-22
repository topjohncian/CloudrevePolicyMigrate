REPO=$(cd $(dirname $0); pwd)
COMMIT_SHA=$(git rev-parse --short HEAD)
VERSION=$(git describe --tags)

_build() {
    local osarch=$1
    IFS=/ read -r -a arr <<<"$osarch"
    os="${arr[0]}"
    arch="${arr[1]}"
    gcc="${arr[2]}"

    # Go build to build the binary.
    export GOOS=$os
    export GOARCH=$arch
    export CC=$gcc
    export CGO_ENABLED=1

    if [ -n "$VERSION" ]; then
        out="release/cloudreve_policy_migrate_${VERSION}_${os}_${arch}"
    else
        out="release/cloudreve_policy_migrate_${COMMIT_SHA}_${os}_${arch}"
    fi

    go build -a -o "${out}"

    if [ "$os" = "windows" ]; then
      mv $out release/cloudreve_policy_migrate.exe
      zip -j -q "${out}.zip" release/cloudreve_policy_migrate.exe
      rm -f "release/cloudreve_policy_migrate.exe"
    else
      mv $out release/cloudreve_policy_migrate
      tar -zcvf "${out}.tar.gz" -C release cloudreve_policy_migrate
      rm -f "release/cloudreve_policy_migrate"
    fi
}

release(){
  cd $REPO
  ## List of architectures and OS to test coss compilation.
  SUPPORTED_OSARCH="linux/amd64/gcc linux/arm/arm-linux-gnueabihf-gcc windows/amd64/x86_64-w64-mingw32-gcc linux/arm64/aarch64-linux-gnu-gcc"

  echo "Release builds for OS/Arch/CC: ${SUPPORTED_OSARCH}"
  for each_osarch in ${SUPPORTED_OSARCH}; do
      _build "${each_osarch}"
  done
}

release