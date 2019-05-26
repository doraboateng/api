package router

import "testing"

func TestGetCorsOptions(t *testing.T) {
	options := GetCorsOptions()

	// There should be at least one allowed origin.
	numOrigins := len(options.AllowedOrigins)
	if numOrigins < 1 {
		t.Errorf("Expected at least one allowed origin, got %d.", numOrigins)
	}
}
