#!/usr/bin/env python3
"""Main module to test the Cache class and its functionality."""

from exercise import Cache, replay

# Create a Cache instance
cache = Cache()

# Store some data
key1 = cache.store("first_data")
key2 = cache.store("second_data")

# Retrieve the data
print(f"Key: {key1}, Data: {cache.get_str(key1)}")
print(f"Key: {key2}, Data: {cache.get_str(key2)}")

# Demonstrate the call_history decorator
print(f"Call history for 'store' method:")
print(f"Inputs: {cache._redis.lrange('Cache.store:inputs', 0, -1)}")
print(f"Outputs: {cache._redis.lrange('Cache.store:outputs', 0, -1)}")

# Run the replay function
replay(cache.store)
