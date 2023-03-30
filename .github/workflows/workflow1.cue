package workflows

_workflow1: _#bashWorkflow & {
	name: "Workflow 1"
	jobs: {
		workflow1_job1: {
			"runs-on": "ubuntu-latest"
			steps: [
				_#step & {
					run: """
						cat <<EOD | jq -c '. as $in | reduce (["type"] + keys)[] as $key ({}; . + { ($key): $in[$key] })'
						{
						  "payload": {
						    "changeID": "Ic230c8e71dbde99e3f621ea6e66d48ff73bd3b3e",
						    "ref": "refs/changes/36/551936/6",
						    "commit": "06111c4686a9e6a30e638edff1383b7a746279f7",
						    "branch": "alpha"
						  },
						  "type": "trybot"
						}
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
