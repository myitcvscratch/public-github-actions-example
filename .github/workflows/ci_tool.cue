package workflows

import (
	"tool/file"
	"encoding/yaml"
)

command: genworkflows: {
	for f, w in workflows {
		"\(f)": file.Create & {
			filename: f + ".yml"
			contents: yaml.Marshal(w)
		}
	}
}
