package workflows

import (
	"json.schemastore.org/github"
)

_#job:  ((github.#Workflow & {}).jobs & {x: _}).x
_#step: ((_#job & {steps:                   _}).steps & [_])[0]

workflows: workflow1: {
	on: [
		"push",
	]
	jobs: {
		workflow1_job1: {
			"runs-on": "ubuntu-latest"
			steps: [
				_#step & {
					run: """
						cat <<EOD
						${{ toJSON(github) }}
						EOD
						"""
				},
			]
		}
	}
}
