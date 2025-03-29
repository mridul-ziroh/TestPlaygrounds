//
//  Untitled.swift
//  InfiniteScroll
//
//  Created by mridul-ziroh on 30/12/24.
//


//
//  ContentView.swift
//  ChatSample
//
//  Created by Uday Patial on 2023-06-12.
//

import Combine
import SwiftUI

struct ComplexScrollToTop: View {
    @State private var message: String = ""
    @State var messages = [
        "blah blah blah1",
        "this is a beautiful message2",
        "this is a random message to my future self3",
        "blah blah blah4",
        "this is a beautiful message5",
        "this is a random message to my future self6",
        "blah blah blah7",
        "this is a beautiful message8",
        "this is a random message to my future self9",
        "blah blah blah10",
        "this is a beautiful message11",
        "this is a random message to my future self12",
        "blah blah blah13",
        "this is a beautiful message14",
        "this is a random message to my future self15",
        "blah blah blah16",
        "this is a beautiful message17",
        "this is a random message to my future self18"
    ]
    var body: some View {
        ScrollViewReader { proxy in
            VStack {
                ScrollView {
                    ScrollViewReader { scrollViewReader in
                        // solves the reuse / performance for scrollview and we dont need to use ListView
                        LazyVStack {
                            ForEach(messages, id: \.self) { message in
                                MessageRow(message: message)
                                    .frame(maxWidth: .infinity)
                                    .id(message)
                            }
                        }
                        .onReceive(Just(messages)) { _ in
                            withAnimation {
                                proxy.scrollTo(messages.first, anchor: .bottom)
                            }
                        }
                    }
                }
                .background(Color.black)
                // text and send button
                HStack {
                    TextField("Send a message", text: $message)
                        .textFieldStyle(.roundedBorder)
                    Button {
                        messages.append(message)
                        print("message appended")
                    } label: {
                        Image(systemName: "paperplane")
                            .fontWeight(.heavy)
                    }
                    .background(
                        Circle()
                            .fill(Color.blue.opacity(0.9))
                            .frame(width: 30, height: 30)
                    )
                    .padding(.leading, 10)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.black)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .onAppear {
                withAnimation {
                    proxy.scrollTo(messages.last, anchor: .bottom)
                }
            }
        }
    }
}

struct MessageRow: View {
    let message: String
    let possibleColors: [UIColor] = [
        .blue,
        .yellow,
        .red,
        .green,
        .purple,
        #colorLiteral(red: 0.1176470588, green: 0.8117647059, blue: 0.737254902, alpha: 1),
        #colorLiteral(red: 0.9607843137, green: 0.5254901961, blue: 0.137254902, alpha: 1),
        #colorLiteral(red: 0.5725490196, green: 0.5725490196, blue: 0.5725490196, alpha: 1),
        #colorLiteral(red: 0.8784313725, green: 0.4862745098, blue: 0.9294117647, alpha: 1),
    ]

    let possibleUserList = [
        "saldtw",
        "rleaez35799",
        "BigRacks225",
        "kjohnson31221",
        "rsterling23918",
        "spreadbet",
        "jjunior91358",
        "hsolo31549",
    ]

    private func generateRandomUser() -> String {
        let randomInt = Int.random(in: 0..<8)
        return possibleUserList[randomInt]
    }

    private func generateRandomColor() -> UIColor {
        let randomInt = Int.random(in: 0..<9)
        return possibleColors[randomInt]
    }

    var body: some View {
        HStack () {
            Image(systemName: "person.circle.fill")
                .frame(width: 30, height: 30)
                .foregroundColor(Color.white)
            VStack(alignment: .leading) {
                Text("Jun 12 at 10:14 PM")
                    .foregroundColor(Color.gray)
                    .font(.system(size: 12))
                Text(generateRandomUser() + ": ")
                    .foregroundColor(Color(generateRandomColor()))
                    .font(.footnote)
                    .fontWeight(.bold) +
                Text(message)
                    .foregroundColor(Color.white)
                    .font(.system(size: 15))
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.bottom)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ComplexScrollToTop()
    }
}
