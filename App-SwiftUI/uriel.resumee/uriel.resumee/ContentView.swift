//
//  ContentView.swift
//  uriel.resumee
//
//  Created by Uriel Alejandro Hernández on 21/01/26.
//

import SwiftUI

struct ContentView: View {
    var nombre = "uriel"
    let edad = "20"
    var experencia = ["proyecto 1, proyecto 2"]
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Nombre: \(nombre) edad: \(edad)")
            ForEach (experencia, id: \.self) { proyecto in
                Text("\(proyecto)")
            }
        }c

        .padding()
    }
}

#Preview {
    ContentView()
}
