//
//  ChatView.swift
//  The Favour
//
//  Created by Atta khan on 22/05/2023.
//

import SwiftUI
struct ChatView: View {
    @State var chat: Chat
    @State private var text: String = ""
    @FocusState private var isFocused
    @State private var messaegIdToScroll: String?
    let colums = [GridItem(.flexible(minimum: 10))]

    var body: some View {
        VStack(spacing: 0) {
            NavigationBarView(text: chat.person.username)
                .padding(20)
            GeometryReader { reader in
                ScrollView {
                    ScrollViewReader { scrollRedear in
                        getMessageView(viewWidth: reader.size.width)
                            .padding(.horizontal)
                            .onChange(of: messaegIdToScroll) { _ in
                                if let messageId = messaegIdToScroll {
                                    scrollTo(messageID: messageId, shouldAnimate: true, scrollReader: scrollRedear)
                                }
                            }
                            .onAppear {
                                if let messageId = chat.messagge.last?.id {
                                    scrollTo(messageID: messageId, anchor: .bottom, shouldAnimate: false, scrollReader: scrollRedear)
                                }
                            }
                    }
                    
                }
            }
            .padding(.bottom, 8)
            toolbarView()
        }
        .padding(.top, 1)
        .navigationBarHidden(true)
        .navigationTitle("")
        
    }
}

extension ChatView {
    func getMessageView(viewWidth: CGFloat) -> some View {
        LazyVGrid(columns: colums, pinnedViews: [.sectionHeaders]) {
            let sectionMessage = getSectionMessage()
            ForEach(sectionMessage.indices, id:\.self) { sectionIndex in
                let messages = sectionMessage[sectionIndex]
                Section(header: sectionHeader(firstMessage: messages.first!)) {
                    ForEach(messages) { msg in
                        let isReceived = msg.type == .received
                        HStack {
                            ZStack {
                                Text(msg.text)
                                    .padding(.horizontal)
                                    .padding(.vertical, 12)
                                    .background(isReceived ? Color.init(hex: "#757575").opacity(0.3) : Color.init(hex: "#7210FF").opacity(0.4))
                                    .foregroundColor(.black)
                                    .cornerRadius(12)
                            }
                            .frame(width: viewWidth * 0.7, alignment: isReceived ? .leading : .trailing )
                            .padding(.vertical)
                        }
                        .frame(maxWidth: .infinity, alignment: isReceived ? .leading : .trailing)
                        .id(msg.id)
                    }
                }

            }
            
            
        }
    }

    func sectionHeader(firstMessage message: Message) -> some View {
        ZStack {
            Text(message.date.descriptiveString(dateStyle: .medium ))
                .foregroundColor(.white)
                .font(.system(size: 12, weight: .regular))
                .frame(width: 120)
                .padding(.vertical, 5)
                .background(Capsule().foregroundColor(Color.blue))
        }
    }
    
    
    func toolbarView() -> some View {
        VStack {
            let height: CGFloat = 37
            HStack {
                TextField("Message ....", text: $text)
                    .padding(.horizontal)
                    .frame(height: height)
                    .background(Color.appTextFieldColor)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .focused($isFocused)
                
                Button {
                    let message = Message(text: text, date: .now, type: .sent)
                    chat.messagge.append(message)
                    text = ""
                    messaegIdToScroll = message.id
                } label: {
                    Image(systemName: "paperplane")
                        .foregroundColor(.blue)
                        .frame(width: height, height: height)
                }
                .disabled(text.isEmpty)
            }
            .frame(height: height)
        }
        .padding(.horizontal)
        .padding(.vertical)
        .background(.white)
    }
    func scrollTo(messageID: String, anchor: UnitPoint? = nil, shouldAnimate: Bool, scrollReader: ScrollViewProxy) {
        DispatchQueue.main.async {
            withAnimation(shouldAnimate ? Animation.easeInOut : nil) {
                scrollReader.scrollTo(messaegIdToScroll, anchor: anchor)
            }
        }
    }
    
    
    
    
    
    func getSectionMessage() -> [[Message]] {
        var res = [[Message]]()
        var temp = [Message]()
        
        for message in chat.messagge {
            if let firstMessage = temp.first {
                let daysBetween = firstMessage.date.daysBetween(date: firstMessage.date)
                if daysBetween >= 1 {
                    res.append(temp)
                    temp.removeAll()
                    temp.append(message)
                } else {
                    temp.append(message)
                }
            } else {
                temp.append(message)
            }
        }
        res.append(temp)
        return res
    }
    
}


struct Chat: Identifiable {
    let id: String = UUID().uuidString
    let booking_id: Int
    let person: Person
    var messagge: [Message]
    var hasUnreadMessage: Bool = false
}


struct Person: Identifiable {
    let id: String = UUID().uuidString
    let userId: Int
    let username: String
    let userImg: String

}

struct Message: Identifiable {
    enum MessageType {
        case sent, received
    }
    let id: String = UUID().uuidString
    let text: String
    let date: Date
    let type: MessageType

    
    init(text: String, date: Date, type: MessageType) {
        self.text = text
        self.date = date
        self.type = type
    }
}


extension Chat {
    static let sampleChat = [
        Chat(booking_id: 1,
             person: Person(userId: 1, username: "Atta khan", userImg: ""),
             messagge: [
                Message(text: "Hey Atta", date: Date(timeIntervalSinceNow: -86400 * 5), type: .sent),
                Message(text: "I am just developing the whatsapp chat clone, but it is so hard to create a fake conversation. can you help me out with it?", date: Date(timeIntervalSinceNow: -86400 * 3), type: .sent),
                Message(text: "Please I need your help", date: Date(timeIntervalSinceNow: -86400 * 3), type: .sent),
                Message(text: "Sure how can I help you", date: Date(timeIntervalSinceNow: -86400 * 3), type: .received),
                Message(text: "Thank you for considering my application. I look forward to the possibility of discussing how I can contribute to [Your Company Name]'s continued excellence in iOS app development. Please feel free to reach out to me at [Your Email Address] or [Your Phone Number] to schedule a conversation at your earliest convenience", date: Date(timeIntervalSinceNow: -86400 * 2), type: .received),
                Message(text: "Please I need your help", date: Date(timeIntervalSinceNow: -86400 * 2), type: .sent),
                Message(text: "Certainly! You can create a rating view screen in SwiftUI that displays empty stars initially and allows users to tap on a star to change its state to a filled star. Here's a step-by-step guide on how to achieve this:", date: Date(timeIntervalSinceNow: -86400 * 1), type: .sent),
                Message(text: "This sets up a simple navigation view with the RatingView as its content.", date: Date(timeIntervalSinceNow: -86400 * 1), type: .sent),
                Message(text: "Run your SwiftUI app, and you should see the rating view with empty stars. Tapping on a star will fill it, and the rating will be displayed accordingly. The user can also input comments in the text area.", date: Date(timeIntervalSinceNow: -86400 * 1), type: .received)
             ]
            )
    ]
}

extension Date {
    func descriptiveString(dateStyle: DateFormatter.Style = .short) -> String {
        let formate = DateFormatter()
        formate.dateStyle = dateStyle

        
        let daysBetween = self.daysBetween(date: Date())
        
        if daysBetween == 0 {
            return "Today"
        }
        else if daysBetween == 1 {
            return "Yesterday"
        }
        else if daysBetween < 5 {
            let weekDayIndex = Calendar.current.component(.weekday, from: self) - 1
            return formate.weekdaySymbols[weekDayIndex]
        }
        
        return formate.string(from: self)
        
        
        
    }
    
    
    func daysBetween(date: Date) -> Int {
        let calendar = Calendar.current
        let date1 = calendar.startOfDay(for: self)
        let date2 = calendar.startOfDay(for: date)
        
        if let daysBeteen = calendar.dateComponents([.day], from: date1, to: date2).day {
            return daysBeteen
        }
        return 0
    }
}

/*
 
 
 
 */
