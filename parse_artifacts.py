#!/usr/bin/env python

import sys, json
#print(sys.argv[1])
artifact_path = sys.argv[2]
json = json.loads(sys.argv[1])

for row in json:
  if row["path"] == artifact_path:
    print row["url"]
