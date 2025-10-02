
from fastapi import FastAPI
from sqlmodel import SQLModel
import random

app = FastAPI()
class Usuario(SQLModel):
    id: str
    nombre_usuario: str
    contrasena: str
    email: str
    is_active: bool
class UsuarioLogin(SQLModel):
    nombre_usuario: str
    contrasena: str
class CrearUsuario(SQLModel):
    nombre_usuario: str
    contrasena: str
    email: str
    def crear_usuario(self):
        return {
            "id": random.randint(10000, 99999),
            "nombre_usuario": self.nombre_usuario,
            "contrasena": self.contrasena,
            "email": self.email,
            "is_active": True
        }
class EliminarUsuario(SQLModel):
    id: int
usuarios_db = [
    {"nombre_usuario": "admin", "contrasena": "password123"},
    {"nombre_usuario": "user1", "contrasena": "1234"}
]
@app.get("/")
async def leer_raiz():
    return {"Hello": "World"}
@app.post("/login")
async def iniciar_sesion(usuario: UsuarioLogin):
    for u in usuarios_db:
        if usuario.nombre_usuario == u["nombre_usuario"] and usuario.contrasena == u["contrasena"]:
            return {"mensaje": "Login correcto"}
    return {"mensaje": "Credenciales inválidas"}
@app.post("/user")
async def crear_usuario(nombre_usuario: str, contrasena: str, email: str):
    nuevo = CrearUsuario(nombre_usuario, contrasena, email).crear_usuario()
    usuarios_db.append(nuevo)
    return {"mensaje": "Usuario creado", "usuario": nuevo}
@app.get("/user")
async def listar():
    usuarios = []
    for u in usuarios_db:
        usuarios.append(u)
    return {"usuarios": usuarios}
@app.get("/users/{usuario_id}")
def obtener_usuario(usuario_id: int):
    for u in usuarios_db:
        if u.get("id") == usuario_id:
            return u
    return {"mensaje": f"Usuario con id {usuario_id} no encontrado"}
@app.put("/users/{usuario_id}")
def actualizar_usuario(usuario_id: int, datos: dict):
    for u in usuarios_db:
        if u.get("id") == usuario_id:
            u.update({k: v for k, v in datos.items() if k != "contrasena"})
            return {"mensaje": "Usuario actualizado", "usuario": u}
    return {"mensaje": "Usuario no encontrado"}
@app.delete("/users/{usuario_id}")
def eliminar_usuario(usuario_id: int):
    for u in usuarios_db:
        if u.get("id") == usuario_id:
            usuarios_db.remove(u)
            return {"mensaje": "Usuario eliminado"}
    return {"mensaje": "Usuario no encontrado"}
