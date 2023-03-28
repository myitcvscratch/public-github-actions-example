package workflows

_workflow1: _#bashWorkflow & {
	name: "Workflow 1"
	jobs: {
		workflow1_job1: {
			if:        "contains(github.event.head_commit.message, '\nTryBot-Trailer: ')"
			"runs-on": "ubuntu-latest"
			steps: [
				_#step & {
					run: """
						cat <<EOD
						${{ toJSON(github) }}
						EOD
						"""
				},
				_#step & {
					run: """
						cat <<EOD
						${{ contains(github.event.head_commit.message, '\nTryBot-Trailer: ') }}
						EOD
						"""
				}
				// if:        "contains(github.event.head_commit.message, '\nTryBotTrailer: ')",,,,,,,,,,,,,,,,,,,,,,
			]
		}
	}
}
