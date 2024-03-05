//
//  ContentView.swift
//  The Favour
//
//  Created by Atta khan on 05/04/2023.
//

import SwiftUI

struct Page: Identifiable, Equatable {
    let id = UUID()
    var name: String
    var description: String
    var imageUrl: String
    var tag: Int
    
    static var samplePage1 = Page(name: "", description: "The best results and your satisfaction is our top priority", imageUrl: "screen1", tag: 0)
    static var samplePage2 = Page(name: "", description: "The best results and your satisfaction is our top priority", imageUrl: "screen2", tag: 0)
    static var samplePage3 = Page(name: "", description: "The best results and your satisfaction is our top priority", imageUrl: "screen3", tag: 0)
    
    static var samplePages: [Page] = [
        Page(name: "", description: "The best results and your satisfaction is our top priority", imageUrl: "screen1", tag: 0),
        Page(name: "Meet new people!", description: "Let me do you a favor", imageUrl: "screen2", tag: 1),
        Page(name: "Edit your face", description: "Let's make awesome changes to your life", imageUrl: "screen3", tag: 2),
    ]

    
    
}


struct ContentView: View {
    @State private var pageIndex = 0
    private let dotAppearance = UIPageControl.appearance()
    private let pages: [Page] = Page.samplePages

    @State private var isShowingDetailView = false

    init(){
        for family in UIFont.familyNames {
             print(family)

             for names in UIFont.fontNames(forFamilyName: family){
             print("== \(names)")
             }
        }
    }

    var body: some View {
        NavigationView {

            VStack {
                NavigationLink(destination: SignupView(), isActive: $isShowingDetailView) { EmptyView() }
                TabView(selection: $pageIndex) {
                    ForEach(pages) { page in
                        VStack {
                            PageView(page: page)
                            Spacer()

                        }
                        .tag(page.tag)
                    }
                }
                .animation(.easeInOut, value: pageIndex)
                .indexViewStyle(.page(backgroundDisplayMode: .interactive))
                .tabViewStyle(.page)
                Spacer()
                if  pageIndex == 2 {
                    FavorButton(text: "Get Started", width: .infinity, height: 58) {
                        self.isShowingDetailView = true

                    }
                    .padding(.horizontal, 24)
                } else {
                    FavorButton(text: "Next", width: .infinity, height: 58) {
                        incrementPage()
                    }
                    .padding(.horizontal, 48)
                }
                Spacer()
                    .onAppear{
                        dotAppearance.currentPageIndicatorTintColor = UIColor(red: 0.647, green: 0.29, blue: 1, alpha: 1)
                        //UIColor(red: 0.647, green: 0.29, blue: 1, alpha: 1).cgColor
                        dotAppearance.pageIndicatorTintColor = .gray
                    }
            }
        }

    }
    func incrementPage() {
        pageIndex += 1
    }
    func goToZero() {
        pageIndex = 0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


