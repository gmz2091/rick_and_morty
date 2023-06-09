//
//  ContentView.swift
//  testingApp
//
//  Created by Magdiel G. on 08/06/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = VewModel()
    @State private var username: String = ""
    
    var body: some View {
        ScrollView {
            VStack {
                TextField(
                        "Character Name",
                        text: $username
                    )
                .extensionTextFieldView(roundedCornes: 6, startColor: .white, endColor: .gray)
                    .onSubmit {
                        getName()
                    }
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .padding()
                Button("Search", action: getName)
                    .buttonStyle(GrowingButton())
                    .padding()
            }
            .frame(maxWidth: .infinity)
            
            VStack {
                if (viewModel.characterBasicByName?.results) != nil {
                    ForEach(viewModel.characterBasicByName!.results, id: \.id) { result in
                        AsyncImage(url: URL(string: result.image))
                        Text("Name:\(result.name)")
                        Text("Gender:\(result.gender.rawValue)")
                        Text("Specie:\(result.species.rawValue)")
                }
                
                }
                if (viewModel.status) {
                    ProgressView()
                }
            }
            .alert(isPresented: $viewModel.viewAlert) {
                        Alert(title: Text("Alert"), message: Text("No se encontraron resultados"), dismissButton: .default(Text("OK")))
                    }
            }
    }
    
    
    func getName() {
        viewModel.executeRequest(nameV: username)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


