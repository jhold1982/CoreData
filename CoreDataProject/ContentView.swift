//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Justin Hold on 10/13/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var moc
    @State private var lastNameFilter = "A"
    @State private var filterType = FilterType.contains
    @State private var sortDescriptors = [SortDescriptor<Singer>]()
    
    var body: some View {
		NavigationStack {
			VStack {
				FilteredList(
					type: filterType,
					filterKey: "lastName",
					filterValue: lastNameFilter,
					sortDescriptors: sortDescriptors
				) { (singer: Singer) in
					Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
				}
				Button("Add Examples") {
					let taylor = Singer(context: moc)
					taylor.firstName = "Taylor"
					taylor.lastName = "Swift"
					
					let ed = Singer(context: moc)
					ed.firstName = "Ed"
					ed.lastName = "Sheeran"
					
					let adele = Singer(context: moc)
					adele.firstName = "Adele"
					adele.lastName = "Adkins"
					
					try? moc.save()
				}
				Button("Show A") {
					lastNameFilter = "A"
				}
				Button("Show S") {
					lastNameFilter = "S"
				}
				Button("Begins With") {
					filterType = .beginsWith
				}
				Button("Contains") {
					filterType = .contains
				}
				Button("Sort A-Z") {
					sortDescriptors = [SortDescriptor(\.firstName)]
				}
				Button("Sort Z-A") {
					sortDescriptors = [SortDescriptor(\.firstName, order: .reverse)]
				}
			}
			.padding()
			.navigationTitle("CoreData")
		}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
