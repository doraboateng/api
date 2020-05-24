package utils

import "strings"

// QueryLimit ...
func QueryLimit(input int, max int) int {
	if input < 1 {
		return 1
	}

	if input > max {
		return max
	}

	return input
}

// Sanitize ...
func Sanitize(input string) string {
	return strings.TrimSpace(input)
}
