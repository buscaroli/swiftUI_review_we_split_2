//
//  ContentView.swift
//  WeSplit2
//
//  Created by Matteo on 27/12/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var numPeople = 2
    @State private var tips = [0, 10, 15, 20, 25]
    @State private var selectedTip = 10
    @State private var totalGross: Double = 0.00
    @State private var quotaToPay = 0.00
    @State private var localCurrencySymbol = Locale.current.currencySymbol
    @State private var localCurrencyCode = Locale.current.currency?.identifier
    @FocusState private var amountIsFocused: Bool
    
    
    var quotaToPayDisplay: String {
        let toPay = totalGross * (100.0 + Double(selectedTip)) / 100.00 / Double(numPeople)
        return String(format: "%.2f",toPay)
    }
    
    var body: some View {
        
        NavigationView {
            Form {
                VStack(alignment: .leading, spacing: 40){
                    Group {
                        Picker(selection: $numPeople, label: Text("How many people").font(.title2)) {
                            ForEach(1...48, id: \.self) { num in
                                Text(String(num))
                            }
                        }
                        
                        Section{
                            Picker(selection: $selectedTip, label: Text("How much to tip?")) {
                                ForEach(tips, id: \.self) { tip in
                                    Text("\(String(tip))%")
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())

                        } header: {
                            Text("How much to tip?")
                                .font(.title2)
                        }
                        
                        Divider()
                                                    
                        Section {
                            TextField("Enter Bill Amount", value: $totalGross, format: .currency(code: localCurrencyCode ?? "USD"))
                                .font(.title)
                                .keyboardType(.decimalPad)
                                .focused($amountIsFocused)
                        } header: {
                            Text("Enter Bill Amount")
                                .font(.title2)
                        }
                        
                        
                    }
                    
                    Divider()
                    
                    Section {
                        Text(" \(localCurrencySymbol ?? "$")\(quotaToPayDisplay) ")
                            .font(.largeTitle)
                        
                    } header: {
                        Text("Quote To Pay")
                            .font(.title2)
                    }
                }
            }
            .navigationTitle("We Split 2")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        amountIsFocused = false
                    }
                    
                }
            }
            
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            ContentView()
            ContentView()
                .preferredColorScheme(.dark)
        }
    }
}
