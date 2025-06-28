#!/bin/bash

# App Expiry Reminder
echo "🚨 REMINDER: Your iOS app will expire in 7 days from build date"
echo "📅 Last build: $(date)"
echo "🔄 Run 'pnpm ios:build' to rebuild when the app expires"
echo "⚡ Run 'pnpm ios:quick' for quick rebuilds during development"

# Add to calendar (macOS)
osascript -e "tell application \"Calendar\" to make new event at end of events of calendar \"Personal\" with properties {summary:\"Rebuild iOS App\", start date:(current date) + 6 * days, end date:(current date) + 6 * days + 1 * hours}" 2>/dev/null || true
