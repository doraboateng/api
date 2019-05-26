package handlers

import (
	"net/http"

	"github.com/doraboateng/api/src/utils"
	"github.com/go-chi/render"
)

// --
// Structures
// --

// Status represents the results of a health check.
type Status struct {
	API string `json:"api"`
}

// StatusResponse is the response payload for the Status data model.
type StatusResponse struct {
	*Status
}

// ---
// Router methods
// ---

// GetHealth returns a health status.
func GetHealth(writer http.ResponseWriter, request *http.Request) {
	status := &Status{
		API: "up",
	}

	if err := render.Render(writer, request, Response(status)); err != nil {
		render.Render(writer, request, utils.RenderingError(err))
		return
	}
}

// ---
// Response handlers
// ---

// Render - renders an InvitationResponse.
func (rd *StatusResponse) Render(w http.ResponseWriter, r *http.Request) error {
	// Pre-processing before a response is marshalled and sent across the wire

	return nil
}

// Response - generates a Status response.
func Response(status *Status) render.Renderer {
	return &StatusResponse{Status: status}
}