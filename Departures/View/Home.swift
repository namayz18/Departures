//
//  Home.swift
//  Departures
//
//  Created by Namasang Yonzan on 09/06/21.
//

import SwiftUI
import CoreLocation

struct Home: View {
    // Variables
    @State private var selectedTypeIndex = 0
    @State private var selectedTrainTypeIndex = 0
    @State private var selectedTramTypeIndex = 0
    @StateObject var mapData = MapViewModel()
    @State var locationManager = CLLocationManager()
    
    var body: some View {
        
        NavigationView {
            ZStack {
                // MapView
                MapView()
                    .environmentObject(mapData)
                    .ignoresSafeArea(.all, edges: .all)
                VStack {
                    HStack {
                        Button(action: {
                            self.selectedTypeIndex = 0
                            mapData.showTransportList()
                        }, label: {
                            Text("All").frame(maxWidth: .infinity, minHeight: 10)
                        })
                        .foregroundColor(Color.white)
                        .padding()
                        .background(self.selectedTypeIndex == 0 ? Color.accentColor : Color.gray)
                        .cornerRadius(8)
                        Button(action: {
                            self.selectedTypeIndex = 1
                            self.selectedTrainTypeIndex = 0
                            self.mapData.showTrainList()
                        }, label: {
                            Text("Train").frame(maxWidth: .infinity, minHeight: 10)
                        })
                        .foregroundColor(Color.white)
                        .padding()
                        .background(self.selectedTypeIndex == 1 ? Color.accentColor : Color.gray)
                        .cornerRadius(8)
                        Button(action: {
                            self.selectedTypeIndex = 2
                            self.selectedTramTypeIndex = 0
                            self.mapData.showTramList()
                        }, label: {
                            Text("Tram").frame(maxWidth: .infinity, minHeight: 10)
                        })
                        .foregroundColor(Color.white)
                        .padding()
                        .background(self.selectedTypeIndex == 2 ? Color.accentColor : Color.gray)
                        .cornerRadius(8)
                    }
                    .frame(maxWidth: .infinity, maxHeight: 20)
                    .padding()
                    if selectedTypeIndex == 1 {
                        HStack {
                            Button(action: {
                                self.selectedTrainTypeIndex = 0
                                self.mapData.showTrainList()
                            }, label: {
                                Text("All").frame(maxWidth: .infinity, minHeight: 10)
                            })
                            .foregroundColor(Color.white)
                            .padding()
                            .background(self.selectedTrainTypeIndex == 0 ? Color.accentColor : Color.gray)
                            .cornerRadius(8)
                            Button(action: {
                                self.selectedTrainTypeIndex = 1
                                self.mapData.showExpressList()
                            }, label: {
                                Text("Express").frame(maxWidth: .infinity, minHeight: 10)
                            })
                            .foregroundColor(Color.white)
                            .padding()
                            .background(self.selectedTrainTypeIndex == 1 ? Color.accentColor : Color.gray)
                            .cornerRadius(8)
                            Button(action: {
                                self.selectedTrainTypeIndex = 2
                                self.mapData.showNormalList()
                            }, label: {
                                Text("Normal").frame(maxWidth: .infinity, minHeight: 10)
                            })
                            .foregroundColor(Color.white)
                            .padding()
                            .background(self.selectedTrainTypeIndex == 2 ? Color.accentColor : Color.gray)
                            .cornerRadius(8)
                        }
                        .frame(maxWidth: .infinity, maxHeight: 20)
                        .padding()
                        
                    } else if selectedTypeIndex == 2 {
                        HStack {
                            Button(action: {
                                self.selectedTramTypeIndex = 0
                                self.mapData.showTramList()
                            }, label: {
                                Text("All").frame(maxWidth: .infinity, minHeight: 10)
                            })
                            .foregroundColor(Color.white)
                            .padding()
                            .background(self.selectedTramTypeIndex == 0 ? Color.accentColor : Color.gray)
                            .cornerRadius(8)
                            Button(action: {
                                self.selectedTramTypeIndex = 1
                                self.mapData.showTopupList()
                            }, label: {
                                Text("Topup").frame(maxWidth: .infinity, minHeight: 10)
                            })
                            .foregroundColor(Color.white)
                            .padding()
                            .background(self.selectedTramTypeIndex == 1 ? Color.accentColor : Color.gray)
                            .cornerRadius(8)
                            Button(action: {
                                self.selectedTramTypeIndex = 2
                                self.mapData.showNoTopupList()
                            }, label: {
                                Text("No Topup").frame(maxWidth: .infinity, minHeight: 10)
                            })
                            .foregroundColor(Color.white)
                            .padding()
                            .background(self.selectedTramTypeIndex == 2 ? Color.accentColor : Color.gray)
                            .cornerRadius(8)
                        }
                        .frame(maxWidth: .infinity, maxHeight: 20)
                        .padding()
                    }
                    Spacer()
                }
            }
            .onAppear(perform: {
                // Setting Delegate...
                self.mapData.fetchItems { _ in
                    print("Success")
                }
                locationManager.delegate = mapData
                locationManager.requestWhenInUseAuthorization()
                mapData.showPlace()
            })
            .alert(isPresented: $mapData.permissionDenied, content: {
                Alert(title: Text("Permission Denied"), message: Text("Please enable permission"), dismissButton: .default(Text("Goto Settings"), action: {
                    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                }))
            })
            // Navigation Title
            .navigationBarTitle(Text("Departures"), displayMode: .inline)
            
        }
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
