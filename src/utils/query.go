package utils

import (
	"fmt"
	"regexp"
	"strings"
)

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

var langCodeRegex = regexp.MustCompile(`^[a-z]{3}(-[a-z]{3})?$`)

// ValidateLangCode ...
func ValidateLangCode(code string) bool {
	return langCodeRegex.MatchString(code)
}

// ResponseToGraphQl ...
func ResponseToGraphQl(response string) string {
	graphql := string(response)
	types := []string{
		"Alphabet",
		"Expression",
		"Language",
		"Reference",
		"Script",
		"Story",
		"StoryLine",
		"Tag",
		"Transliteration",
	}

	for i := 0; i < len(types); i++ {
		graphql = strings.ReplaceAll(graphql, fmt.Sprintf("%s.", types[i]), "")
	}

	return graphql
}
