import redis

# считаю что почта - уникальная а вот имя пользователя может быть одинаковым,
email_s = redis.Redis(db=0)
user_s = redis.Redis(db=1)

email_ = 'n.taradanov@gmail.com'
fio_ = 'Taradanov Nikolay Vladimirovich'
# email_ = 'n.taradanov@gmail.co'
# fio_ = 'Taradanov Nikolay Vladimirovich+'

# при добавлении связки пользовател+емаил
# добавлю почтовый адрес

email_s.set(email_, fio_)

# добавлю в список по имени пользователя почтовый адрес
user_s.sadd(fio_, email_)

# получить имя пользователя по адресу
print(email_s.get(email_))

# список почтовых адресов по имени пользователя
print(user_s.sscan(fio_))

user_s.close()
email_s.close()
pass

