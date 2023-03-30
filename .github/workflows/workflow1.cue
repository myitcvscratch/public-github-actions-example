package workflows

_workflow1: _#bashWorkflow & {
	name: "Workflow 1"
	jobs: {
		workflow1_job1: {
			"runs-on": "ubuntu-latest"
			steps: [
				_#step & {
					run: """
						cat <<EOD
						${{ toJSON(github.event) }}
						EOD
						"""
				},
				_#step & {
					name: "No braces"
					if:   "contains(github.event.head_commit.message, '\nTryBot-Trailer: {')"
					run:  "echo No braces matched"
				},
				_#step & {
					name: "Braces"
					if:   "${{ contains(github.event.head_commit.message, '\nTryBot-Trailer: {') }}"
					run:  "echo No braces matched"
				},
			]
		}
	}
}
