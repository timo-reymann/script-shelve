#!/usr/bin/env python3
import requests
from argparse import ArgumentParser

parser = ArgumentParser("Fetch release info from JetBrains")
parser.add_argument("--max-releases", help="Number of last releases to fetch", required=False, default=5)
parser.add_argument("--products", help="List with product codes", required=False, default=["IIC","IIU", "PCP", "PCC", "RM", "PS", "GO", "WS"], nargs="*")
args = parser.parse_args()

parameter= {
  "fields": ",".join([
        "code",
        "name",
        "releases.type",
        "releases.build",
        "releases.version"
    ])
}

if len(args.products) > 0:
    parameter["code"] = ",".join(args.products)

res = requests.get("https://data.services.jetbrains.com/products", params=parameter)

products = res.json()
result = {}

for product in products:
    if len(product['code']) <= 2 or product['code'].startswith("II"):
        normalized_code = product['code'][-2:]
    else:
        normalized_code = product['code']

    print(f"// {normalized_code} - {product['name']}")
    releases = 0
    print("[")
    for release in product['releases']:
        if release['type'] != 'release':
            continue

        print(f'\t"{normalized_code}-{release["build"]}", // {release["version"]}')
        releases += 1
        if releases == int(args.max_releases):
            break
    print("]")
    print("")


