#!/usr/bin/env python3
"""
Web cache module
"""
import requests
import redis
from typing import Callable

def get_page(url: str) -> str:
    cache = redis.Redis()
    cached_page = cache.get(f"count:{url}")
    if cached_page:
        return cached_page.decode('utf-8')

    response = requests.get(url)
    cache.setex(f"count:{url}", 10, response.text)
    cache.incr(f"count:{url}")
    return response.text
