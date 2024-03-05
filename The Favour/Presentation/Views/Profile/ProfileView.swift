//
//  ProfileView.swift
//  The Favour
//
//  Created by Atta khan on 26/04/2023.
//

import SwiftUI
import HalfASheet

enum UserMode {
    case seller
    case buyer
}

class UserModeViewModel: ObservableObject {
    @Published var userMode: UserMode = .buyer
}

struct ProfileView: View {
    @State var isOn = false
    
    @State var showLogoutSheet: Bool = false
    @EnvironmentObject var userModeViewModel: UserModeViewModel

    
    @State private var isShowHome = false
    @State private var isEditProfile = false
    @State private var isPaymentScreen = false
    @State private var isSecurityScreen = false
    @State private var isPrivacy = false
    @State private var isReport = false
    @State private var isAlert = false
    @State var shouldPerformLogout: Bool = false
    @State private var user: User?

    @StateObject var viewModel: AthenticationViewModel = AthenticationViewModel()

    var body: some View {
        NavigationView {
            ZStack {
                ScrollView {
                    VStack(alignment: .center) {
                        Group {
                            NavigationLink(destination: SignupView1(isUpdate: true), isActive: $isEditProfile) { EmptyView() }
                            NavigationLink(destination: AddPaymentMethods(), isActive: $isPaymentScreen) { EmptyView() }
                            NavigationLink(destination: SecurityView(), isActive: $isSecurityScreen) { EmptyView() }
                            NavigationLink(destination: PrivacyPolicyView(), isActive: $isPrivacy) { EmptyView() }
                            NavigationLink(destination: ReportView(), isActive: $isReport) { EmptyView() }
                            NavigationLink(destination: AlertView(), isActive: $isAlert) { EmptyView() }
                            
                        }
                        topBar
                        avatarImage
                        personalInfo
                        if isOn == false {
                            availableBalance
                                .padding(.vertical, 4)
                            FavorButton(text: "Withdraw",  width: 134, height: 34, bgColor: .appLightBlack) {
                            }
                        }
                        //                    switchAccount
                        FavorDividerView(width: UIScreen.screenWidth - 24 , height: 1)
                            .padding( .trailing, 24)
                        menuItems
                        Spacer()
                    }
                    .padding([.top, .leading], 24)
                }
                
                // MARK: - HALF SHEET FOR LOGOUT
                HalfASheet(isPresented: $showLogoutSheet, title: "Logout") {
                    VStack(spacing: 16) {
                        FavorDividerView(width: .infinity, height: 1)
                        FavorText(text: "Are you sure you want to log out?",
                                  textColor: Color(#colorLiteral(red: 0.26, green: 0.26, blue: 0.26, alpha: 1)) , fontType: .bold, fontSize: 20, alignment: .center, lineSpace: 0)
                        .padding(.vertical, 24)
                        HStack {
                            FavorButton(text: "Cancel", width: .infinity, height: 44, textColor: .appPrimaryColor, bgColor: Color(red: 0.945, green: 0.906, blue: 1)) {
                            }
                            FavorButton(text: "Yes, Logout", width: .infinity, height: 44, bgColor: .appPrimaryColor) {
                                
                            }
                        }
                        .padding(.horizontal, 24)
                        .padding(.bottom, 16)
                    }
                }
                
                .height(.proportional(0.3))
                .backgroundColor(.white)
                .contentInsets(EdgeInsets(top: 50, leading: 10, bottom: 5, trailing: 10))
            }
            .navigationBarHidden(true)
            .navigationTitle("")
            .fullScreenCover(isPresented: $shouldPerformLogout) {
                NavigationView {
                    SignupView()
                }
            }
            .onAppear {
                // Retrieve the User object from UserDefaults when the view appears
                let decoder = JSONDecoder()
                if let data = UserDefaults.standard.data(forKey: "currentUser"),
                   let storedUser = try? decoder.decode(User.self, from: data) {
                    self.user = storedUser
                }
            }
        }

    }
        
    private var topBar: some View {
        HStack(spacing: 16) {
            Image("hear_logo")
                .resizable()
                .scaledToFit()
                .frame(width: 32, height: 32)
            FavorText(text: "Profile", textColor: Color(#colorLiteral(red: 0.13, green: 0.13, blue: 0.13, alpha: 1)), fontType: .bold, fontSize: 24, alignment: .center, lineSpace: 0)
            Spacer()
        }
    }
    
    private var avatarImage: some View {
        ZStack(alignment: .bottomTrailing) {
            
            if let img = user?.profile_photo {
                AvatarView(image: Image("user_profile"), size: 120, profileImageURL: URL(string: img)!)
            } else {
                AvatarView(image: Image("user_profile"), size: 120, profileImageURL: nil)
            }
            
            Image("edit_profile")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30, height: 30)
                .padding(.all, 4)
            
        }
    }
    
    private var personalInfo: some View {
        VStack(spacing: 4) {
            FavorText(text: user?.name ?? "", textColor: Color(#colorLiteral(red: 0.13, green: 0.13, blue: 0.13, alpha: 1)), fontType: .bold, fontSize: 24, alignment: .center, lineSpace: 0)
            
            FavorText(text: user?.email ?? "", textColor: .appLightGrey, fontType: .semiBold, fontSize: 14, alignment: .center, lineSpace: 0)
            
        }
    }
    
    
    private var availableBalance: some View {
        Text("Available Balance ").font(.custom("Urbanist Bold", size: 18)).foregroundColor(Color(#colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1))) + Text("$0.00").font(.custom("Urbanist Bold", size: 18)).foregroundColor(Color(#colorLiteral(red: 0.65, green: 0.29, blue: 1, alpha: 1)))

    }
    
    private var switchAccount: some View {
        Toggle(isOn: Binding<Bool>(
            get: { self.userModeViewModel.userMode == .buyer },
            set: { newValue in
                self.userModeViewModel.userMode = newValue ? .buyer : .seller
            }
        )) {
            FavorText(text: self.isOn ? "I can do you a favor" : "I need a favor" , textColor: Color(#colorLiteral(red: 0.65, green: 0.29, blue: 1, alpha: 1)), fontType: .semiBold, fontSize: 12, alignment: .center, lineSpace: 0)
            }
        .tint(.appPrimaryColor)
        .frame(width: UIScreen.screenWidth / 2, alignment: .center)
    }
    
    
    
    private var menuItems: some View {
        VStack(spacing: 24) {
//            SettingMenuItem(title: "Home", image: "Home", isLogout: false) {
//                isShowHome = true
//            }
            SettingMenuItem(title: "Edit Profile", image: "Profile", isLogout: false){
                isEditProfile = true
            }

//            SettingMenuItem(title: "Payment", image: "Wallet", isLogout: false){
//                //isPaymentScreen = true
//            }
//
//            SettingMenuItem(title: "Security", image: "Shield Done", isLogout: false){
//                //isSecurityScreen = true
//            }

            SettingMenuItem(title: "Privacy Policy", image: "Lock", isLogout: false) {
               isPrivacy = true
            }
//            SettingMenuItem(title: "Report", image: "Lock", isLogout: false) {
//               isReport = true
//            }
            SettingMenuItem(title: "Alerts", image: "lock", isLogout: false) {
               isAlert = true
            }
            
            SettingMenuItem(title: "Logout", image: "Logout", isLogout: true) {
                showLogoutSheet = true
                shouldPerformLogout = true
                PrefsManager.shared.favorType = ""
                KeychainManager.performLogout()
            }

        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}


extension View {
    func halfSheet<SheetView: View>(showSheet: Binding<Bool>, @ViewBuilder sheetView: @escaping () -> SheetView) -> some View {
        return self
            .background {
                HalfSheetHelper(sheetView: sheetView(), showSheet: showSheet )
            }
    }
}


struct HalfSheetHelper<SheetView: View> : UIViewControllerRepresentable {
    var sheetView: SheetView
    @Binding var showSheet: Bool
    let controller = UIViewController()
    
    func makeUIViewController(context: Context) -> some UIViewController {
        controller.view.backgroundColor = .clear
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        if showSheet {
            let sheetController = CustomHostingController(rootView: sheetView)
            
            uiViewController.present(sheetController, animated: true) {
                DispatchQueue.main.async {
                    self.showSheet.toggle()
                }
            }
        }
    }
}


// Custom UIHostingController for halfsheet....
class CustomHostingController<Content: View>: UIHostingController<Content> {
    override func viewDidLoad() {
        if let presentationController = presentationController as? UISheetPresentationController {
            presentationController.detents = [.medium() ]
            
            presentationController.prefersGrabberVisible = true
        }
    }
}
