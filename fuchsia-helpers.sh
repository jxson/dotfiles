
export FUCHSIA_WORKSPACE="${CODE}/fuchsia"
if [ -d $FUCHSIA_WORKSPACE ]; then
  export PATH="${FUCHSIA_WORKSPACE}/.jiri_root/bin:$PATH"
  export JIRI_ROOT="${FUCHSIA_WORKSPACE}"
fi

function fgo() {
  cd "${FUCHSIA_WORKSPACE}/$1"
}

function mbuild() {
  (fgo magenta && ./scripts/build-magenta-x86-64) && \
    (fgo && ./scripts/build-sysroot.sh -c -t x86_64)
}

function fbuild() {
  (fgo && ./packages/gn/gen.py --ccache $@ && ./buildtools/ninja -C out/debug-x86-64 -j18)
}

function fboot() {
  (fgo out/build-magenta/build-magenta-pc-x86-64 && ./tools/bootserver magenta.bin $FUCHSIA_WORKSPACE/out/debug-x86-64/user.bootfs $@)
}

function fenv() {
  export PATH="${PATH}:${FUCHSIA_WORKSPACE}/magenta/build-magenta-pc-x86-64/tools"
}

function freboot() {
  (fenv && netruncmd : "dm reboot")
}

function femail() {
 (fenv && netruncmd : "@ /system/apps/bootstrap /system/apps/device_runner --user-shell=file:///system/apps/email_user_shell")
}
