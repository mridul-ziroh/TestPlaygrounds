import SwiftUI

struct InfiniteScrollNewsApp: View {
    @StateObject var datasource: MainViewModel = MainViewModel()
    @State var ShowScrollToTop: Bool = false
    var body: some View {
        VStack {
            switch datasource.state {
                
            case .loading:
                loadingView
                
            case .empty(_):
                makeMessageView("No Article")
            default :
                contentView
            }
        }
        .onAppear(){
            Task{
                await datasource.fetchArticles()
            }
        }
    }
    
    private func makeMessageView(_ message: String) -> some View {
        Text(message)
            .foregroundStyle(.red)
            .font(.headline)
    }
    
    private var contentView: some View {
        ScrollViewReader { proxy in
            ZStack (alignment: .bottomTrailing){
                List{
                    itemsView
                    
                    switch datasource.state {
                    case .loadingNextPage:
                        LoadingProgressView()
                    case .data, .nextPageData:
                        LoadingProgressView()
                        Text("Loading")
                            .onAppear {
                                Task { await datasource.fetchNextArticles() }
                            }
                    default:
                        EmptyView()
                    }
                }
                .scrollDismissesKeyboard(.immediately)
                .scrollContentBackground(.hidden)
                .listStyle(.plain)
                
                if ShowScrollToTop {
                    HStack {
                        Button {
                            withAnimation {
                                proxy.scrollTo(datasource.articles.first, anchor: .top)
                            }
                            
                        } label: {
                            Image(systemName: "chevron.up.2")
                                .foregroundStyle(.black)
                                .padding()
                                .background(.cyan.opacity(0.9))
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                        }
                    }
                    .padding(.trailing)
                }
            }
        }
    }
    
    private var itemsView: some View {
        ForEach(datasource.articles, id: \.self) { article in
            LazyVStack {
                AsyncImage(url: URL(string: article.urlToImage ?? "https://media.wired.com/photos/674769026811d4146e6fa13b/191:100/w_1280,c_limit/cyber-monday-apple-deals.png")){ phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image.resizable()
                            .scaledToFit()
                        //                                .frame(width: 200, height: 200)
                    case .failure:
                        Image("IMG_0001")
                            .resizable()
                            .scaledToFit()
                    @unknown default:
                        EmptyView()
                    }
                }
                Text(article.title ?? "default")
            }
            .id(article)
            .onAppear(){
                if let index = datasource.articles.firstIndex(where: { $0 == article }) {
                    if index > 10 {
                        ShowScrollToTop = true
                    } else {
                        ShowScrollToTop = false
                    }
                }
            }
        }
    }
    private var loadingView: some View {
        LoadingProgressView()
    }
}
