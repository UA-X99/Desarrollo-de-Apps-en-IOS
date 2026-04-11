// Sistema de Usuarios - Plataforma Digital

import Foundation

// Clase base Usuario
class Usuario {
    
    var nombre: String
    var email: String
    private var password: String
    private(set) var activo: Bool
    
    // Inicializador completo
    init(nombre: String, email: String, password: String, activo: Bool) {
        self.nombre = nombre
        self.email = email
        self.password = password
        self.activo = activo
    }
    
    // Inicializador con valores por defecto
    convenience init(nombre: String, email: String) {
        self.init(nombre: nombre, email: email, password: "123456", activo: true)
    }
    
    // Verifica si la contraseña es correcta
    func login(password: String) -> Bool {
        return self.password == password
    }
    
    // Cambia la contraseña si la actual es correcta y la nueva tiene minimo 6 caracteres
    func cambiarPassword(actual: String, nueva: String) -> Bool {
        guard self.password == actual else {
            print("Error: la contraseña actual no es correcta")
            return false
        }
        guard nueva.count >= 6 else {
            print("Error: la nueva contraseña debe tener al menos 6 caracteres")
            return false
        }
        self.password = nueva
        print("Contraseña cambiada correctamente")
        return true
    }
    
    func activar() {
        activo = true
        print("Usuario \(nombre) activado")
    }
    
    func desactivar() {
        activo = false
        print("Usuario \(nombre) desactivado")
    }
    
    // Muestra la info del usuario sin mostrar el password
    func descripcion() {
        print("--- Usuario ---")
        print("Nombre: \(nombre)")
        print("Email: \(email)")
        print("Activo: \(activo ? "Si" : "No")")
        print("---------------")
    }
    
    // fileprivate para que el Administrador pueda resetear la contraseña
    // desde este mismo archivo sin exponer password directamente
    fileprivate func resetearPasswordInterno(nueva: String) -> Bool {
        guard nueva.count >= 6 else {
            print("Error: la contraseña debe tener al menos 6 caracteres")
            return false
        }
        self.password = nueva
        print("Contraseña reseteada para \(nombre)")
        return true
    }
}


// Subclase Administrador que hereda de Usuario
class Administrador: Usuario {
    
    var nivelAcceso: Int
    
    init(nombre: String, email: String, password: String, activo: Bool, nivelAcceso: Int) {
        self.nivelAcceso = nivelAcceso
        super.init(nombre: nombre, email: email, password: password, activo: activo)
    }
    
    convenience init(nombre: String, email: String, nivelAcceso: Int) {
        self.init(nombre: nombre, email: email, password: "admin123", activo: true, nivelAcceso: nivelAcceso)
    }
    
    // Sobreescribe descripcion para incluir nivel de acceso
    override func descripcion() {
        print("--- Administrador ---")
        print("Nombre: \(nombre)")
        print("Email: \(email)")
        print("Activo: \(activo ? "Si" : "No")")
        print("Nivel de acceso: \(nivelAcceso)")
        print("---------------------")
    }
    
    // Solo puede eliminar (desactivar) usuarios si tiene nivel >= 5
    func eliminarUsuario(_ usuario: Usuario) {
        guard nivelAcceso >= 5 else {
            print("Permiso denegado: se necesita nivel >= 5 (tienes \(nivelAcceso))")
            return
        }
        usuario.desactivar()
        print("El admin \(nombre) elimino al usuario \(usuario.nombre)")
    }
    
    // Resetea la contraseña usando el metodo fileprivate de Usuario
    func resetearPassword(usuario: Usuario, nueva: String) {
        guard nivelAcceso >= 5 else {
            print("Permiso denegado: se necesita nivel >= 5 (tienes \(nivelAcceso))")
            return
        }
        if usuario.resetearPasswordInterno(nueva: nueva) {
            print("Contraseña reseteada por el admin \(nombre)")
        }
    }
}


// Subclase Cliente que hereda de Usuario
class Cliente: Usuario {
    
    private var saldo: Double  // private porque es dato sensible
    fileprivate var historialCompras: [String]  // accesible solo dentro del archivo
    
    init(nombre: String, email: String, password: String, activo: Bool, saldoInicial: Double) {
        self.saldo = saldoInicial
        self.historialCompras = []
        super.init(nombre: nombre, email: email, password: password, activo: activo)
    }
    
    convenience init(nombre: String, email: String) {
        self.init(nombre: nombre, email: email, password: "cliente1", activo: true, saldoInicial: 0.0)
    }
    
    // Solo acepta cantidades positivas
    func depositar(_ cantidad: Double) {
        guard cantidad > 0 else {
            print("Error: la cantidad debe ser positiva")
            return
        }
        saldo += cantidad
        print("Se depositaron $\(String(format: "%.2f", cantidad)). Saldo actual: $\(String(format: "%.2f", saldo))")
    }
    
    // Compra un producto si hay saldo suficiente
    func comprar(producto: String, precio: Double) {
        guard precio > 0 else {
            print("Error: el precio debe ser positivo")
            return
        }
        guard saldo >= precio else {
            print("Saldo insuficiente. Tienes $\(String(format: "%.2f", saldo)) y cuesta $\(String(format: "%.2f", precio))")
            return
        }
        saldo -= precio
        historialCompras.append("\(producto) - $\(String(format: "%.2f", precio))")
        print("Compra realizada: \(producto) por $\(String(format: "%.2f", precio)). Te queda: $\(String(format: "%.2f", saldo))")
    }
    
    func verSaldo() -> Double {
        return saldo
    }
    
    override func descripcion() {
        print("--- Cliente ---")
        print("Nombre: \(nombre)")
        print("Email: \(email)")
        print("Activo: \(activo ? "Si" : "No")")
        print("Saldo: $\(String(format: "%.2f", saldo))")
        if historialCompras.isEmpty {
            print("Compras: ninguna")
        } else {
            print("Historial de compras:")
            for i in 0..<historialCompras.count {
                print("  \(i + 1). \(historialCompras[i])")
            }
        }
        print("---------------")
    }
}
