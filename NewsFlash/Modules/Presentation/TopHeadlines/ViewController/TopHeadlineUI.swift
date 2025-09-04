//
//  TopHeadlineUI.swift
//  NewsFlash
//
//  Created by Mena Maher on 9/4/25.
//

import SwiftUI

struct TopHeadlineUI: View {
    let employees = ["Alice", "Bob", "Charlie", "David", "Eva"]
    @State private var searchText = ""

    var filteredEmployees: [String] {
        if searchText.isEmpty {
            return employees
        } else {
            return employees.filter { $0.localizedCaseInsensitiveContains(searchText) }
        }
    }

    var body: some View {
        VStack(spacing: 16) {
            // Custom search bar + another view beside it
            HStack {
                SearchBar(text: $searchText)

                Button(action: {
                    print("Filter tapped")
                }) {
                    Image(systemName: "line.3.horizontal.decrease.circle")
                        .font(.title2)
                }
                .padding(.trailing)
            }

            // Your list
            List(filteredEmployees, id: \.self) { employee in
                Text(employee)
            }

            Spacer()
        }
        .padding(.top)
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
                .cornerRadius(10)
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
//        var txtValue: String
//        var size: CGFloat
//        var weight: Font.Weight
//        var color: Color
        
        var body: some View {
            Text("")
//                .font(.system(size: size, weight: weight))
////                .frame(maxWidth: .infinity, alignment: .leading)
//                .foregroundStyle(color)
//                .lineLimit(nil)
//                .fixedSize(horizontal: false, vertical: true)
        }
    }
}

#Preview {
    TopHeadlineUI()
}
