//
//  TopHeadlineUI.swift
//  NewsFlash
//
//  Created by Mena Maher on 9/4/25.
//

import SwiftUI

struct TopHeadlineUI: View {
    @EnvironmentObject var uiState: BaseUIState

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
                CountryFilterView()
            }
            .padding()
            
            Button("Show Loader") {
                uiState.showLoading(true)
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    uiState.showLoading(false)
                }
            }

            Button("Show Toast") {
                uiState.showToast("This is a toast message!")
            }

            
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
        @State private var selectedCountryValue: String = "eg"
        private let countries = LoadCountiesUtil.loadCountries()

        var body: some View {
            ZStack {
                HStack {
                    Text(selectedCountryValue.uppercased())
                        .font(.system(size: 13, weight: .regular))
                        .foregroundStyle(.black)
                    
                    Image(systemName: "chevron.down")
                        .foregroundColor(.black)
                    
                }

                Picker("", selection: $selectedCountryValue) {
                    ForEach(countries, id: \.value) { country in
                        Text(country.name)
                            .tag(country.value)
                    }
                }
                .labelsHidden()
                .pickerStyle(.menu)
                .opacity(0.02)
                .contentShape(Rectangle())
                .frame(maxWidth: .infinity)
                .clipped()
                .onChange(of: selectedCountryValue) { _, newValue in
                    print("User selected: \(newValue)")
                }
            }
            .frame(width: 60, height: 48)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(UIColor(hex: "E0E0E0")), lineWidth: 1)
            )
        }
    }
}

#Preview {
    TopHeadlineUI()
}
