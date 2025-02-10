#!/usr/bin/python

# $Id: 1.txt,v 1.1 2025/02/10 12:29:39 digua Exp $

import re
import sys
import subprocess
from datetime import datetime

AUTHOR="dongdigua"

def get_git_file_info(org_path):
    commit_date = subprocess.check_output(
        ['git', 'log', '-1', '--format=%cd', '--date=iso', org_path],
        text=True
    ).strip()

    commit_date = datetime.strptime(commit_date, "%Y-%m-%d %H:%M:%S %z").strftime("%Y/%m/%d %H:%M:%S")

    try:
        tag = subprocess.check_output(
            ['git', 'describe', '--tags', '--abbrev=0'],
            text=True
        ).strip()
    except subprocess.CalledProcessError:
        tag = "unknown" 

    return commit_date, tag

def replace_id_keyword(html_path, org_path, commit_date, tag):
    with open(html_path, 'r') as file:
        content = file.read()

    new_content = re.sub(
        r'</h1>',
        f'</h1><p style=text-align:center><code>$Id: {org_path},v {tag} {commit_date} {AUTHOR} Exp $</code></p>',
        content
    )

    with open(html_path, 'w') as file:
        file.write(new_content)

def main():
    html_path = sys.argv[1]
    org_path = re.sub(r'\.html$', '.org', html_path).replace("../", "", 1)

    commit_date, tag = get_git_file_info(org_path)

    replace_id_keyword(html_path, org_path, commit_date, tag)
    print(f"Updated $Id$ in {html_path} with tag {tag} and date {commit_date}")

if __name__ == '__main__':
    main()
