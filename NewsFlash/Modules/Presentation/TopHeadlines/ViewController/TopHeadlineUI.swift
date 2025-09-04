//
//  TopHeadlineUI.swift
//  NewsFlash
//
//  Created by Mena Maher on 9/4/25.
//

import SwiftUI

struct TopHeadlineUI: View {
//    let employees = ["Alice", "Bob", "Charlie", "David", "Eva"]
    @State private var searchText = ""
    
//    var filteredEmployees: [String] {
//        if searchText.isEmpty {
//            return employees
//        } else {
//            return employees.filter { $0.localizedCaseInsensitiveContains(searchText) }
//        }
//    }
    
    var body: some View {
        VStack(spacing: 11) {
            HStack {
                SearchBar(text: $searchText)
                    CountryFilterView(selectedCountryValue: "eg")
            }
            .padding()

//            // Your list
//            List(filteredEmployees, id: \.self) { employee in
//                Text(employee)
//            }
//            
//            Spacer()
        }
        Spacer()
    }
    
    struct SearchBar: View {
        @Binding var text: String
        @State private var isEditing = false
        
        var body: some View {
            HStack {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.black)
                    
                    TextField("Search...", text: $text)
                        .foregroundColor(.primary)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                    
                    if !text.isEmpty {
                        Button(action: {
                            self.text = ""
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.gray)
                        }
                    }
                }
                .padding(8)
                .frame(height: 48)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(UIColor(hex: "E0E0E0")), lineWidth: 1))
                
                
                if isEditing {
                    Button("Cancel") {
                        self.text = ""
                        self.isEditing = false
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }
                    .foregroundColor(.blue)
                    .transition(.move(edge: .trailing))
                    .animation(.default, value: isEditing)
                }
            }
            .padding(.horizontal)
            .onTapGesture {
                self.isEditing = true
            }
        }
    }
    
    struct CountryFilterView: View {
        @State var selectedCountryValue: String = "eg"
        private let countries = LoadCountiesUtil.loadCountries()

        var body: some View {
            HStack {
                Picker(selection: $selectedCountryValue,
                    label: Text(selectedCountryValue.uppercased())) {
                    ForEach(countries, id: \.value) { country in
                        Text(country.value)
                            .tag(country.value)
                    }
                }
                .pickerStyle(.menu)
                .tint(.black)
                .onChange(of: selectedCountryValue, { _, newValue in
                    print("User selected: \(newValue)")
                })
            }
            .frame(height: 48)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(UIColor(hex: "E0E0E0")), lineWidth: 1))
        }
    }
}

#Preview {
    TopHeadlineUI()
}
