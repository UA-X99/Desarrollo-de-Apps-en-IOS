// Programa principal - pruebas del sistema

print("=== Sistema de Usuarios ===")
print()

// --- Pruebas con Usuario ---
print("-- Probando Usuario --")
print()

let usuario1 = Usuario(nombre: "Ana Garcia", email: "ana@mail.com", password: "segura123", activo: true)
usuario1.descripcion()

// usuario con convenience init (valores por defecto)
let usuario2 = Usuario(nombre: "Pedro Lopez", email: "pedro@mail.com")
usuario2.descripcion()

// probando login
print("Login correcto: \(usuario1.login(password: "segura123"))")
print("Login incorrecto: \(usuario1.login(password: "otrapass"))")
print()

// cambiar contraseña - caso incorrecto
print("Intentando cambiar con contraseña actual mal:")
_ = usuario1.cambiarPassword(actual: "mala", nueva: "nueva123")

// cambiar contraseña - nueva muy corta
print("Intentando con nueva muy corta:")
_ = usuario1.cambiarPassword(actual: "segura123", nueva: "abc")

// cambiar contraseña - todo bien
print("Cambiando correctamente:")
_ = usuario1.cambiarPassword(actual: "segura123", nueva: "nuevaPass1")
print("Login con la nueva: \(usuario1.login(password: "nuevaPass1"))")
print()

// activar y desactivar
usuario1.desactivar()
print("Esta activo? \(usuario1.activo)")
usuario1.activar()
print("Esta activo? \(usuario1.activo)")
print()


// --- Pruebas con Administrador ---
print("-- Probando Administrador --")
print()

let admin = Administrador(nombre: "Carlos", email: "carlos@admin.com", nivelAcceso: 8)
admin.descripcion()

let adminJr = Administrador(nombre: "Luisa", email: "luisa@admin.com", nivelAcceso: 3)
adminJr.descripcion()

// admin con nivel bajo intenta eliminar usuario
print("Admin nivel 3 intenta eliminar:")
adminJr.eliminarUsuario(usuario2)
print("Pedro sigue activo? \(usuario2.activo)")
print()

// admin con nivel alto elimina usuario
print("Admin nivel 8 elimina:")
admin.eliminarUsuario(usuario2)
print("Pedro sigue activo? \(usuario2.activo)")
print()

// resetear contraseña
print("Admin nivel 3 intenta resetear contraseña:")
adminJr.resetearPassword(usuario: usuario1, nueva: "reset123")

print("Admin nivel 8 resetea contraseña:")
admin.resetearPassword(usuario: usuario1, nueva: "reset123")
print("Login con contraseña reseteada: \(usuario1.login(password: "reset123"))")
print()


// --- Pruebas con Cliente ---
print("-- Probando Cliente --")
print()

let cliente1 = Cliente(nombre: "Maria", email: "maria@mail.com", password: "compras1", activo: true, saldoInicial: 500.0)
cliente1.descripcion()

let cliente2 = Cliente(nombre: "Jorge", email: "jorge@mail.com")
cliente2.descripcion()

// depositar
print("Depositando cantidad negativa:")
cliente2.depositar(-50)
print("Depositando $200:")
cliente2.depositar(200.0)
print()

// comprar sin saldo
print("Intentando comprar sin saldo suficiente:")
cliente2.comprar(producto: "Laptop", precio: 999.99)
print()

// compras exitosas
print("Comprando productos:")
cliente1.comprar(producto: "Teclado", precio: 45.99)
cliente1.comprar(producto: "Mouse", precio: 25.50)
cliente1.comprar(producto: "Monitor", precio: 320.00)
print()

print("Saldo de \(cliente1.nombre): $\(String(format: "%.2f", cliente1.verSaldo()))")
print()

// descripcion con historial
cliente1.descripcion()


// --- Polimorfismo ---
print("-- Polimorfismo --")
print()

let usuarios: [Usuario] = [usuario1, admin, adminJr, cliente1, cliente2]

for u in usuarios {
    u.descripcion()
    print()
}

print("Fin de las pruebas")
