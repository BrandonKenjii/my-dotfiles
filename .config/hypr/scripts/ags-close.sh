#!/bin/bash
if ags list -i media-popup 2>/dev/null | grep -q "media-popup"; then
    # Check if window is visible via ags
    ags request "close-popup" -i media-popup 2>/dev/null || true
fi
