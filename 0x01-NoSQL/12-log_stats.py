#!/usr/bin/env python3
"""
Python script that provides some stats about Nginx logs stored in MongoDB:
"""

import pymongo

client = pymongo.MongoClient()
db = client.logs

total_logs: int = db.nginx.count_documents({})
mthd = {
    "GET": db.nginx.count_documents({"method": "GET"}),
    "POST": db.nginx.count_documents({"method": "POST"}),
    "PUT": db.nginx.count_documents({"method": "PUT"}),
    "PATCH": db.nginx.count_documents({"method": "PATCH"}),
    "DELETE": db.nginx.count_documents({"method": "DELETE"})
}

status_path = db.nginx.count_documents({"path": "/status"})

patch = f"\n\tmethod PUT: {mthd['PUT']}\n\tmethod PATCH: {mthd['PATCH']}"
print(f"{total_logs} logs\nMethods:")
print(f"\tmethod GET: {mthd['GET']}\n\tmethod POST: {mthd['POST']}", end="")
print(patch, end="")
print(f"\n\tmethod DELETE: {mthd['DELETE']}")
print(f"{status_path} status check")
