#!/usr/bin/env python3
"""Module defining a Cache class for interacting with Redis."""

import redis
import uuid
from typing import Callable, Optional
import functools  # Add this import


def call_history(method: Callable) -> Callable:
    """Decorator to store the history of inputs and outputs of a method."""
    @functools.wraps(method)  # Use functools.wraps
    def wrapper(self, *args, **kwargs):
        """Wraps the method to store history."""

        # Store inputs
        self._redis.rpush(f"{method.__qualname__}:inputs", str(args))

        # Call the original method
        result = method(self, *args, **kwargs)

        # Store outputs
        self._redis.rpush(f"{method.__qualname__}:outputs", result)

        return result
    return wrapper


class Cache:
    """Class to interact with Redis."""

    def __init__(self):
        """Initialize a new Cache instance."""
        self._redis = redis.Redis()
        self._redis.flushdb()

    @call_history
    def store(self, data: str) -> str:
        """Store data in Redis with a random key and return the key."""
        key = str(uuid.uuid4())
        self._redis.set(key, data)
        return key

    def get(self, key: str, fn: Optional[Callable] = None) -> str:
        """Retrieve data from Redis and apply a function if provided."""
        value = self._redis.get(key)
        if fn:
            return fn(value)
        return value

    def get_str(self, key: str) -> str:
        """Retrieve data as a string."""
        return self.get(key, lambda d: d.decode("utf-8"))

    def get_int(self, key: str) -> int:
        """Retrieve data as an integer."""
        return self.get(key, lambda d: int(d))


def replay(method: Callable) -> None:
    """Displays the history of calls of a particular method."""
    redis_instance = method.__self__._redis
    inputs = redis_instance.lrange(f"{method.__qualname__}:inputs", 0, -1)
    outputs = redis_instance.lrange(f"{method.__qualname__}:outputs", 0, -1)
    print(f"Call history for {method.__qualname__}:")
    for input, output in zip(inputs, outputs):
        print(f"Input: {input}, Output: {output}")
