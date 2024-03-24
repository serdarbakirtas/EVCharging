import SwiftUI

import SwiftUI

extension TabbarView {
    enum Tab: Hashable {
        case home
        case search
        case map
        case profile
    }
}

struct TabbarView: View {
    @State private var selectedTab: Tab = .home

    var body: some View {
        TabView(selection: $selectedTab) {
            ChargingLocationView()
                .tag(Tab.home)
                .preferredColorScheme(.dark)
                .background(Color.white)

            FakeEmptyView()
                .tag(Tab.search)

            FakeEmptyView()
                .tag(Tab.map)

            FakeEmptyView()
                .tag(Tab.profile)
        }
        .overlay(
            Color.white
                .edgesIgnoringSafeArea(.vertical)
                .frame(height: 83) // The height of a tab bar is default 68 points.
                .shadow(color: Color.black.opacity(0.2), radius: 16, x: 0, y: 2)
                .overlay(
                    HStack {
                        TabBarButton(tab: .home, image: Asset.Tabbar.home.imageView, selectedTab: $selectedTab)
                        Spacer()
                        TabBarButton(tab: .search, image: Asset.Tabbar.search.imageView, selectedTab: $selectedTab)
                        Spacer()
                        TabBarButton(tab: .map, image: Asset.Tabbar.map.imageView, selectedTab: $selectedTab)
                        Spacer()
                        TabBarButton(tab: .profile, image: Asset.Tabbar.profile.imageView, selectedTab: $selectedTab)
                    }
                    .padding(EdgeInsets(top: 16, leading: 40, bottom: 48, trailing: 40))
                ),
            alignment: .bottom
        )
        .edgesIgnoringSafeArea(.all)
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct TabBarButton: View {
    let tab: TabbarView.Tab
    let image: Image
    @Binding var selectedTab: TabbarView.Tab

    var body: some View {
        Button(action: {
            selectedTab = tab
        }, label: {
            image
                .foregroundColor(selectedTab == tab ? Color.jucrPrimary : Color.jucrSecondary)
        })
    }
}

struct FakeEmptyView: View {
    var body: some View {
        VStack {}
    }
}

#Preview {
    TabbarView()
}
