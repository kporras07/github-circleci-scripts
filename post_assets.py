#!/usr/bin/env python3

import sys, json, requests, re, os
base_url = "https://api.github.com"
owner = sys.argv[1]
repo = sys.argv[2]
tag_name = sys.argv[3]
filename = sys.argv[4]

base_path = "/repos/" + owner + "/" + repo + "/releases/tags/"
endpoint = base_url + base_path + tag_name
response = requests.get(endpoint)
release = response.json()
upload_url = release['upload_url']
real_upload_url = re.match("(.*)\{", upload_url).group(1)
token = os.environ['GITHUB_TOKEN']

headers = {
  'Accept': 'application/vnd.github.v3+json',
  'Authorization': 'token ' + token,
  'Content-Type': 'application/gzip'
}

response = requests.post(real_upload_url + '?name=' + filename, headers = headers, data = open(filename, 'rb').read())
