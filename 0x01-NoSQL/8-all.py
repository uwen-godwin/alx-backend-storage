#!/usr/bin/end python3
"""
Module 8-all
Contains a function that list all documents in a collection
"""
def list_all(mongo_collection):
  """ List all documents in a collection """
  return [doc for doc in mongo_collection.find()]


