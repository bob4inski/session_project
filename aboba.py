from ipaddress import IPv4Network
from random import choice
from random import randint
from random import randrange
from unittest import result

global simbols,numbers,alphabet_high,alphabet_low

simbols = '+-/*!&$#?=@<>'
numbers = '1234567890'
alphabet_low = 'abcdefghijklnopqrstuvwxyz'
alphabet_high = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'

def pwsd_quality():
    answers = []
    print('А сейчас блиц опрос по сложности пароля')
    questions = ['верхний регистр','нижний регистр','цифры','символы']
    parts = [alphabet_high,alphabet_low,numbers,simbols]
    k = 0 
    for i in questions:
        print(f'Будем ли использовать {i} в составе пароля?(ответ только yes/no')
        answer = None
        while answer != 'no' and answer != 'n'  and  answer != 'yes' and answer != 'y':
            answer = input()
            answer = answer.lower()
            if answer == 'no' or answer == 'n':
                pass
            elif answer == 'yes' or answer == 'y':
                k += 1 #смотрим сколько у нас должно быть минимум символов в пароле в зависимости от выбранных опций
                pass
            else:
                print('нужно правильно написать yes или no')

        answers.append(answer)

    n = int(input("Введите число символов в пароле\n"))
    while n < k:
        n = int(input(f"при выбранных опциях минимальная длина пароля = {k}\n"))
    
    answers.append(n)
    parts_length = n // k
    last_part_length = n % k
    result = []
    for i in range(4):
        if answers[i] == 'y' or answers[i] == 'yes':
            result.append(gen_part_of_pswd(parts_length,parts[i]))
    if last_part_length >=1 :
        result.append(gen_part_of_pswd(last_part_length,parts[randrange(1,last_part_length + 1)]))
    
    # result = shuffle(''.join(result)))
    return shuffle(result)

def shuffle(a):
    result = []
    a = ''.join(a)
    for i in a:
        result.append(i)
    res_len = len(result)
    for i in range(len(result)):
        ran = randrange(res_len)
        result[i],result[ran] = result[ran],result[i]
    return ''.join(result)


def gen_part_of_pswd(a,b):
    part = ''
    for j in range(a):
        part += choice(b)
    return part

# def magic_network():

#     pass
print(pwsd_quality())
