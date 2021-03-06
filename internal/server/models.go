package server

import "github.com/MontFerret/worker/pkg/worker"

type (
	HttpError struct {
		Error string `json:"error"`
	}

	Script struct {
		worker.Query
	}

	ChromeVersion struct {
		Browser  string `json:"Browser"`
		Protocol string `json:"Protocol-Version"`
		V8       string `json:"V8-Version"`
		WebKit   string `json:"WebKit-Version"`
	}

	Version struct {
		Worker string        `json:"worker"`
		Chrome ChromeVersion `json:"chrome"`
		Ferret string        `json:"ferret"`
	}
)
