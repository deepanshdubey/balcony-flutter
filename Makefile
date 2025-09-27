
all: clean get build_runner intl run

# Get all dependencies
get:
	@echo "Fetching dependencies..."
	flutter pub get

# Clean the build
clean:
	@echo "Cleaning up builds..."
	flutter clean

# Run the Flutter application
run:
	@echo "Running app..."
	flutter run

# Build the Flutter application
build:
	@echo "Building app..."
	flutter build web

# Build APK for Android
apk:
	@echo "Building Android APK..."
	flutter build apk

# Build iOS app
ios:
	@echo "Building iOS app..."
	flutter build ios

build_runner :
	@echo "Generating intermediates"
	dart run build_runner build --delete-conflicting-outputs

watch :
	@echo "Generating intermediates"
	flutter run build_runner watch --delete-conflicting-outputs

intl :
	@echo "Generating Language files"
	 flutter pub global run intl_utils:generate

