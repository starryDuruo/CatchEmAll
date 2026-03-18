//
//  ContentView.swift
//  CatchEmAll
//
//  Created by Wang Sige on 3/17/26.
//

import SwiftUI

struct CreaturesListView: View {
    var creatures = ["Pikachu"]
    var body: some View {
        NavigationStack{
            List(creatures, id: \.self) { creature in
                Text(creature)
                    .font(.title2)
            }
            .listStyle(.plain)
            .navigationTitle("Pokemon")
        }
    }
}

#Preview {
    CreaturesListView()
}
