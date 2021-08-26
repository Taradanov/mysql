import random
import redis

r = redis.Redis()

# ключём будет ИП адрес, ограничу диапазон
for i in range(1000000):
    ip = '192.168.0.' + str(random.randint(0, 255))
    if r.exists(ip):
        r.incr(ip)
    else:
        r.set(ip, 1)

for i in r.keys():
    print(i, r.get(i))
