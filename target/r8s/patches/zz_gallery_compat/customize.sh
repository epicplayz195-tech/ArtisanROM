# SPDX-License-Identifier: GPL-3.0-or-later
SKIPUNZIP=1

if [[ "$TARGET_CODENAME" != "r8s" || "$SOURCE_PLATFORM_SDK_VERSION" -lt 36 ]]; then
    return 0
fi

# Keep Samsung's authentication and storage implementations. The modern PASS
# service is absent on the r8s vendor; use Gallery's existing legacy provider
# only when SemPassStorageManager reports that it is unavailable.
# Fork build: these patches don't match the current source Gallery, so a
# mismatch is skipped with a warning instead of failing the whole ROM build.
for GALLERY_PATCH in gallery-storage gallery-toolbar; do
    if ! APPLY_PATCH "system" "system/priv-app/SamsungGallery2018/SamsungGallery2018.apk" \
            "$MODPATH/$GALLERY_PATCH.patch"; then
        LOGW "Skipping $GALLERY_PATCH.patch: it does not apply to this Gallery build"
    fi
done
