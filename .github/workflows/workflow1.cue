package workflows

_workflow1: _#bashWorkflow & {
	name: "Workflow 1"
	jobs: {
		workflow1_job1: {
			"runs-on": "ubuntu-latest"
			steps: [
				_#checkoutCode,
				_#step & {
					run: """
						cat <<EOD
						${{ toJSON(github) }}
						EOD
						"""
				},
				_#step & {
					id: "unityTrailer"
					run: """
						x="$(git log -1 --pretty='%(trailers:key=Unity-Trailer,valueonly)')"
						if [ "$x" == "" ]
						then
							x=null
						fi
						echo "unityTrailer<<EOD" >> $GITHUB_OUTPUT
						echo "$x" >> $GITHUB_OUTPUT
						echo "EOD" >> $GITHUB_OUTPUT
						"""
				},
				_#step & {
					if: "${{ fromJSON(steps.unityTrailer.outputs.unityTrailer) == null }}"
					run: """
						echo "No trailer set"
						"""
				},
				_#step & {
					if: "${{ fromJSON(steps.unityTrailer.outputs.unityTrailer) != null }}"
					run: """
						echo CL is ${{ fromJSON(steps.unityTrailer.outputs.unityTrailer).CL }}
						echo patchset is ${{ fromJSON(steps.unityTrailer.outputs.unityTrailer).patchset }}
						"""
				},
				_#step & {
					run: """
						cat <<EOD | tr '\n' ' '
						${{ toJSON(github.event.head_commit.author) }}
						EOD
						"""
				},
			]
		}
	}
}
