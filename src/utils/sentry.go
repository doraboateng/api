package utils

import (
	"log"
	"os"

	"github.com/getsentry/sentry-go"
)

func getSentryOptions(dsn string, version string) sentry.ClientOptions {
	return sentry.ClientOptions{
		Dsn:         dsn,
		Debug:       os.Getenv("BOATENG_ENV") != "production",
		Environment: os.Getenv("BOATENG_ENV"),
		Release:     version,
	}
}

// SetupSentry ...
func SetupSentry(version string) {
	dsn := os.Getenv("SENTRY_DSN")

	if dsn == "" {
		log.Println("Sentry DSN not found.")
		return
	}

	if err := sentry.Init(getSentryOptions(dsn, version)); err != nil {
		log.Fatalf("sentry.Init: %s", err)
	}
}
