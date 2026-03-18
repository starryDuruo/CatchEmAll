//
//  CreaturesListView.swift
//  CatchEmAll
//
//  Created by Wang Sige on 3/17/26.
//

import SwiftUI

struct CreaturesListView: View {
    @State var creatures = Creatures()
    var body: some View {
        NavigationStack{
            ZStack{
                List(0..<creatures.creaturesArray.count, id: \.self) { index in
                    LazyVStack {
                        NavigationLink {
                            DetailView(creature: creatures.creaturesArray[index])
                        } label: {
                            Text("\(index+1). \(creatures.creaturesArray[index].name.capitalized)")
                                .font(.title2)
                        }
                    }
                    .task {
                        guard let lastCreatures = creatures.creaturesArray.last else {
                            return
                        }
                        if creatures.creaturesArray[index].name == lastCreatures.name && creatures.urlString.hasPrefix("http"){
                            await creatures.getData()
                        }
                                
                    }
              }
                .listStyle(.plain)
                .navigationTitle("Pokemon")
                .toolbar {
                    ToolbarItem(placement: .status) {
                        Text("\(creatures.creaturesArray.count) of \(creatures.count) creatures")
                    }
                }
                
                if creatures.isLoading {
                    ProgressView()
                        .tint(.red)
                        .scaleEffect(4)
                }
            }
        }
        .task {
            await creatures.getData()
        }
    }
}

#Preview {
    CreaturesListView()
}
