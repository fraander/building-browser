//
//  CarouselView.swift
//  BuildingBrowserNU
//
//  Created by Frank Anderson on 9/29/22.
//

import SwiftUI

struct CarouselView: View {
    @EnvironmentObject var searchable: Searching
    @Binding var currentLoc: Location?
    
    var locations: [Location] {
        return searchable.searchText.isEmpty ? Examples.locations : Examples.locations.filter {
            $0.name.lowercased().contains(searchable.searchText.lowercased())
        }
    }
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 18) {
                ForEach(locations) { loc in
                    NavigationLink {
                        DetailView(currentLoc: $currentLoc, location: loc)
                    } label: {
                        VStack {
                            loc.photo
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .clipShape(RoundedRectangle(cornerRadius: 12.0))
                                .shadow(radius: 2)
                            
                            HStack {
                                loc.category.symbol()
                                    .foregroundColor(loc.category.color())
                                Text(loc.name)
                                    .font(.system(.body, design: .rounded, weight: .regular))
                            }
                        }
                    }
                    .buttonStyle(.plain)
                    .padding(.bottom, 12)
                }
            }
            .padding(.horizontal, 18)
        }
        .frame(height: 240)
    }
}

struct CarouselView_Previews: PreviewProvider {
    static var previews: some View {
        CarouselView(currentLoc: .constant(Examples.iv))
    }
}
