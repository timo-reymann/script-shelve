#!/usr/bin/env python3
import requests

MAX_RELEASES = 5
PRODUCT_CODES = [
    "PS",
    "IIU",
    "IIC"
]

res = requests.get("https://data.services.jetbrains.com/products", params={
    "code": ",".join(PRODUCT_CODES),
    "fields": ",".join([
        "code",
        "name",
        "releases.type",
        "releases.build",
        "releases.version"
    ])
})

products = res.json()
result = {}

for product in products:
    normalized_code = product['code'][-2:]
    print(f"// {normalized_code} - {product['name']}")
    releases = 0
    for release in product['releases']:
        if release['type'] != 'release':
            continue

        print(f'"{normalized_code}-{release["build"]}", // {release["version"]}')
        releases += 1
        if releases == MAX_RELEASES:
            break
    print("")


