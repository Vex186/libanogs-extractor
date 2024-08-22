RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${RED}t.me/honorofkingsmaphack${NC}"
echo -e "${RED}vex1337${NC}"
APK_DIR="/data/app"  
TARGET_BASE_DIR="/data/app"  
LIB_PATH="lib/arm64-v8a/libanogs.so"
TARGET_SUBDIR="lib/arm64"


APK_PATH=$(find "$APK_DIR" -type d -name "com.levelinfinite.sgameGlobal*" | head -n 1)

if [ -z "$APK_PATH" ]; then
    echo "com.levelinfinite.sgameGlobal not found"
    exit 1
fi


APK_FILE=$(find "$APK_PATH" -name "split_config.arm64_v8a.apk" | head -n 1)

if [ -z "$APK_FILE" ]; then
    echo "split_config.arm64_v8a.apk not found"
    exit 1
fi


TEMP_DIR=$(mktemp -d)


unzip -o "$APK_FILE" "$LIB_PATH" -d "$TEMP_DIR"

if [ ! -f "$TEMP_DIR/$LIB_PATH" ]; then
    echo "libanogs.so dosyası çıkarılamadı."
    rm -rf "$TEMP_DIR"
    exit 1
fi


TARGET_DIR=$(find "$TARGET_BASE_DIR" -type d -name "com.levelinfinite.sgameGlobal*" | head -n 1)

if [ -z "$TARGET_DIR" ]; then
    echo "Hedef com.levelinfinite.sgameGlobal dizini bulunamadı."
    rm -rf "$TEMP_DIR"
    exit 1
fi


mv "$TEMP_DIR/$LIB_PATH" "$TARGET_DIR/$TARGET_SUBDIR"

# Geçici dizini temizleme
rm -rf "$TEMP_DIR"

echo "Dosya başarıyla çıkarıldı ve $TARGET_DIR/$TARGET_SUBDIR dizinine taşındı."
