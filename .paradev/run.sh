#!/usr/bin/env bash
set -euo pipefail

# Device defaults to Chrome; override with REPSTER_DEVICE (e.g. linux, a device id).
exec flutter run -d "${REPSTER_DEVICE:-chrome}" --dart-define-from-file=.env
