#!/usr/bin/env python3
"""
Python function that returns the list of school having a specific topic
"""


def schools_by_topic(mongo_collection, topic: str):
    """
    Parameters:
        mongo_collection: object
            mongo object which passes access to the mongo collection cursor
        topic: str
            filter to be passed into function for searching

    Returns:
        list
            all document object that matches the filter
    """
    mongo_list = []
    mongo_data = mongo_collection.find({"topics": topic})

    # iterate through the data object recieved from the database
    for data in mongo_data:
        mongo_list.append(data)

    return mongo_list
