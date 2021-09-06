import rsa

modulus = 'srpKIOhwy7AWKLEdC7ybjqeaqd0pIaZf3qiNMU43JgXMBMd/jOGaIRsUQ25hajEg/d1XgzZcMeZNVpUHVTJz13pZv7+YlIDqwzeDMtQWRXbpEWA8L08Pu3/mbrKdY8pmF7dkdEDShD6wv9M6hMu/sjPV9S7YslVSGRPRgw1jsBk='
exponent = 'AQAB'

key = rsa.PublicKey(modulus, exponent)
print(key)