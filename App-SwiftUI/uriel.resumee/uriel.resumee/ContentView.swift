//
//  ContentView.swift
//  uriel.resumee
//
//  Created by Uriel Alejandro Hernández on 21/01/26.
//

import SwiftUI

struct ContentView: View {
    
    var nombre = "Uriel"
    let edad = "20"
    
    var experencia = [
        "Aplicación desarrollada en Android Studio",
        "Certificado en Big Data"
    ]
    
    var education = [
        "Universidad Tecmilenio"
    ]
    
    @State private var showAlert = false
    @State private var perfilActivo = false
    @State private var nivel: Double = 50
    
    var body: some View {
        VStack(spacing: 15) {
            
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            
            Text("Nombre: \(nombre)")
            Text("Edad: \(edad)")
            
            Text("Experiencia:")
                .font(.headline)
            
            ForEach(experencia, id: \.self) { proyecto in
                Text("• \(proyecto)")
            }
            
            Text("Formación académica:")
                .font(.headline)
            
            ForEach(education, id: \.self) { estudio in
                Text("• \(estudio)")
            }
            
            Button("Cursos") {
                showAlert = true
            }
            .alert("Cursos en 2025", isPresented: $showAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text("Curso 1: Big Data\nCurso 2: Computer Vision\nCurso 3: Data Science.")
            }
            
            Divider()
            
            // Toggle Perfil
            HStack {
                Text("Perfil")
                Spacer()
                Toggle("", isOn: $perfilActivo)
                    .labelsHidden()
            }
            
            if perfilActivo {
                Text("Scrum Master")
                    .foregroundColor(.red)
                    .font(.headline)
            }
            
            // Slider Nivel
            Text("Nivel: \(Int(nivel))")
            
            Slider(value: $nivel, in: 0...100, step: 1)
            
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
