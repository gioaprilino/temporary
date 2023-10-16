# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/BlissRoms/platform_manifest.git -b typhoon -g default,-mips,-darwin,-notdefault
git clone https://github.com/giosaja96/local_manifest.git --depth 1 -b main .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build bliss 1
source build/envsetup.sh
lunch bliss_mojito-userdebug
export TZ=Asia/Jakarta #put before last build command
export KBUILD_BUILD_USER=dioparminggo
export KBUILD_BUILD_HOST=bliss
export BUILD_USERNAME=dioparminggo
export BUILD_HOSTNAME=bliss
blissify -g mojito

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
