'''
Escreva um programa em C equivalente a este.

Note que em C:

- Pode usar a função `fgets` (man:fgets) para ler uma linha completa de texto.
- As strings são arrays de carateres e usa-se o caráter '\0' como terminador.
- As strings não guardam o seu comprimento.  Por isso, usar `strlen` pode sair
  caro!
- Os carateres (tipo `char`) são um tipo de inteiro e podem ser convertidos
  implicitamente de e para `int`.
- Pode usar `toupper` (man:toupper) para converter um caráter para maiúscula.

'''

def main():
    print('Enter text. Empty line to stop.')
    while True:
        text = input('text: ')
        if text == '': break
        print('code:', enc0d3(text))

def enc0d3(s):
    #      'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
    CODE = 'A8CD3F6H1JKLMN0PQR57UVWXY2'
    N = len(CODE)
    t = ''
    for c in s.upper():
        n = ord(c) - ord('A')
        t += CODE[n] if 0 <= n < N else c
    return t

if __name__ == '__main__':
    main()

