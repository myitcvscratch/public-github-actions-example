package workflows

import (
	"json.schemastore.org/github"
)

// TODO: drop when cuelang.org/issue/390 is fixed.
// Declare definitions for sub-schemas
_#job:  ((github.#Workflow & {}).jobs & {x: _}).x
_#step: ((_#job & {steps:                   _}).steps & [_])[0]

workflows: [...{
	filename: string
	workflow: github.#Workflow
}]
workflows: [
	{
		filename: "workflow1.yml"
		workflow: _workflow1
	},
]

_#bashWorkflow: github.#Workflow & {
	on: [
		"push",
		"pull_request",
	]
	jobs: [string]: defaults: run: shell: "bash"
}

_#installGo: _#step & {
	name: "Install Go"
	uses: "actions/setup-go@v2"
	with: "go-version": string
}

_#checkoutCode: _#step & {
	name: "Checkout code"
	uses: "actions/checkout@v3"
}

_#goTest: _#step & {
	name: "Test"
	run:  "go test"
}

_#run: _#step & {
	#arg: string
	name: "Run"
	run:  "go run main.go \"from \(#arg) using ${{ matrix.go-version }}\""
}
